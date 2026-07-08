# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Vanilla Tetris implementation using HTML5 Canvas. No dependencies, no build step, no package.json, no tests. Three files: `index.html` (DOM/canvas structure), `style.css` (dark/retro theme), `game.js` (all game logic, ~300 lines).

## Running

No install or build step. Open `index.html` directly in a browser, or serve statically:

```bash
npx serve .
# or: python3 -m http.server 8000
```

There is no test suite, linter, or bundler configured — verify changes by opening the page and playing.

## Architecture (`game.js`)

- **Board model**: `board` is a `ROWS × COLS` matrix; each cell is `0` (empty) or a color index 1–7 identifying the locked piece type.
- **Pieces**: `PIECES` array holds the 7 tetrominoes as square matrices. `current` and `next` are `{ type, shape, x, y }`. Rotation (`rotateCW`) transposes + reverses rows; `tryRotate` applies wall kicks by testing offsets `[0, -1, 1, -2, 2]` until one doesn't collide.
- **Collision** (`collide`): checks board bounds and overlap with already-locked cells; used for movement, rotation, and the ghost-piece projection.
- **Game loop** (`loop`): driven by `requestAnimationFrame`, accumulates elapsed time in `dropAccum` and advances the piece one row when `dropAccum >= dropInterval`.
- **Locking/scoring**: `lockPiece` → `merge` (writes piece into `board`) → `clearLines` (scans bottom-up, splices full rows, unshifts empty ones) → `spawn` (promotes `next` to `current`, generates a new `next`; if the new piece immediately collides, `endGame()` fires).
- **Scoring/level**: line clears use `LINE_SCORES = [0, 100, 300, 500, 800]` × `level`; hard drop adds 2 pts/row, soft drop 1 pt/row. Level increments every 10 lines; `dropInterval = max(100, 1000 - (level-1)*90)` ms.
- **Rendering**: `draw()` clears and redraws the grid, locked board, ghost piece (`globalAlpha = 0.2`, via `ghostY()` projecting straight down), and the current piece, each frame. `drawNext()` renders the preview canvas separately.
- All game state (`board`, `current`, `next`, `score`, `lines`, `level`, `paused`, `gameOver`, timing vars) lives in module-level `let` bindings reset by `init()`.

Tunable constants at the top of `game.js`: `COLS`, `ROWS`, `BLOCK`, `COLORS`, `LINE_SCORES`, initial `dropInterval`. If `COLS`/`ROWS`/`BLOCK` change, update the `#board` canvas `width`/`height` in `index.html` to match (`COLS×BLOCK` by `ROWS×BLOCK`).

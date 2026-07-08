---
name: weather
description: Consulta el clima y la temperatura actual de una ciudad ejecutando una petición local a wttr.in (sin necesidad de búsqueda web). Úsala cuando el usuario pida el clima, la temperatura o el pronóstico de una ciudad, por ejemplo "dime el clima en Denia" o "/weather Madrid".
---

# Weather

Obtiene el clima actual de una ciudad de forma local (vía `curl`, sin usar WebSearch).

## Uso

Ejecuta el script pasando la ciudad como argumento (por defecto `Denia,Spain` si no se indica ninguna):

```bash
bash .claude/skills/weather/scripts/weather.sh "Denia,Spain"
```

El script llama a `https://wttr.in` y devuelve una línea con: ubicación, condición, temperatura, sensación térmica, humedad y viento, en español.

## Notas

- Requiere `curl` y conexión a internet (la petición es local en el sentido de que no pasa por la herramienta WebSearch/LLM, es una llamada HTTP directa).
- Si `curl` falla (sin red, servicio caído), informa el error al usuario en vez de reintentar en bucle.
- Para otra ciudad, pasa el nombre como argumento, con `+` o `%20` si tiene espacios (el script ya sustituye espacios por `+`).

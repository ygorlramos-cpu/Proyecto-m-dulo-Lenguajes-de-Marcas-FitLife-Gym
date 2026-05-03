# 📋 Informe del Módulo — Lenguajes de Marcas y SGI

**Proyecto:** FitLife Gym  
**Módulo:** Lenguajes de Marcas y Sistemas de Gestión de Información (0373)  
**Fecha:** Mayo 2025

---

## 1. ¿Qué datos representa el XML?

El archivo `xml/datos.xml` representa el sistema de gestión de un gimnasio llamado **FitLife Gym**. Contiene tres entidades principales:

- **Socios**: datos personales, tipo de membresía (básica/premium), estado (activo/baja/suspendido) e inscripciones a clases.
- **Entrenadores**: datos del personal con su especialidad (musculación, yoga, cardio, etc.).
- **Clases**: información de cada actividad ofrecida: tipo, horario, aforo, precio mensual y entrenador responsable.

Las relaciones entre entidades se implementan con atributos `ID` e `IDREF`:
- Cada `<socio>` contiene `<inscripcion ref_clase="Cxxx">` que referencia a un `<clase id="Cxxx">`.
- Cada `<clase>` tiene `<ref_entrenador>` que apunta al id de un `<entrenador>`.

---

## 2. ¿Cómo se valida con el DTD?

### Archivo DTD: `xml/modelo.dtd`

El DTD valida:
- **Estructura de elementos**: orden y jerarquía obligatoria (`gimnasio > socios > socio > nombre, email...`)
- **Cardinalidades**: `socio+` (al menos uno), `inscripcion*` (cero o más)
- **Tipos de atributos**:
  - `ID` / `IDREF` para garantizar referencias válidas
  - Enumeraciones para restringir valores permitidos
- **Restricciones por enumeración**:
  - `estado` del socio: solo `activo | baja | suspendido`
  - `especialidad` del entrenador: solo `musculacion | yoga | cardio | crossfit | pilates`
  - `tipo` de clase: solo `musculacion | yoga | cardio | crossfit | pilates`
  - `dia` del horario: solo días de la semana válidos

### Comandos de validación

```bash
# Validar el XML correcto con el DTD
xmllint --noout --dtdvalid xml/modelo.dtd xml/datos.xml

# Resultado esperado: sin salida (validación correcta)

# Validar el XML incorrecto para demostrar control de errores
xmllint --noout --dtdvalid xml/modelo.dtd xml/datos_error.xml

# Resultado esperado: errores de validación (valores no permitidos en enumeraciones)
```

> **Nota:** `xmllint` está disponible en Linux/Mac. En Windows usar XMLSpy, VS Code con extensión XML o validadores online como [xmlvalidation.com](https://www.xmlvalidation.com).

---

## 3. ¿Cómo ejecutar la transformación XSLT y visualizar el HTML?

### Opción A — Con `xsltproc` (Linux/Mac)

```bash
# Desde la raíz del proyecto
xsltproc xml/transform.xsl xml/datos.xml > informe.html

# Abrir en el navegador
open informe.html        # Mac
xdg-open informe.html    # Linux
```

### Opción B — Con `Saxon` (multiplataforma, Java)

```bash
java -jar saxon-he.jar -s:xml/datos.xml -xsl:xml/transform.xsl -o:informe.html
```

### Opción C — Directamente en el navegador

Abrir `xml/datos.xml` en Firefox (Chrome bloquea XSLT local por seguridad). Firefox aplica automáticamente la hoja `transform.xsl` gracias a la instrucción de procesamiento en la cabecera del XML:

```xml
<?xml-stylesheet type="text/xsl" href="../xml/transform.xsl"?>
```

### Resultado

El HTML generado incluye:
- Portada con nombre del gimnasio y fecha
- Tabla de socios activos e inactivos/suspendidos
- Tabla de entrenadores
- Tabla de clases activas y canceladas
- Cards de resumen con estadísticas
- Estilos CSS aplicados desde `css/estilo.css`

---

## 4. ¿Dónde ver la evidencia?

| Archivo | Descripción |
|---|---|
| `docs/validacion_dtd.png` | Captura de pantalla de `xmllint` con validación correcta |
| `docs/error_dtd.png` | Captura de `xmllint` mostrando errores del XML incorrecto |
| `docs/transform_html.png` | Captura del HTML generado en el navegador |

---

## 5. ¿Cómo encaja en el proyecto FitLife Gym?

### Integración real con la app

**Exportación desde la BBDD:**  
La app puede exportar los datos de socios, clases y entrenadores desde la base de datos MySQL a `datos.xml` y `datos.json`, permitiendo hacer copias de seguridad estructuradas y legibles.

**Reporte navegable:**  
El XML + XSLT genera automáticamente un informe HTML navegable del estado del gimnasio (socios activos, clases disponibles, etc.) que puede enlazarse desde el panel de administración de la app.

**Importación parcial:**  
El JSON equivalente (`json/datos.json`) puede usarse para importar datos iniciales a la base de datos o para sincronizar información entre módulos del proyecto.

**Documentación de configuración:**  
El XML sirve como estructura de referencia para definir los tipos de membresías, especialidades de entrenadores y tipos de clases disponibles en el sistema.

---

## 6. Estructura del repositorio

```
fitlife/
├── xml/
│   ├── datos.xml          # XML principal con datos del gimnasio
│   ├── modelo.dtd         # DTD que valida la estructura del XML
│   ├── transform.xsl      # Transformación XSLT → HTML
│   └── datos_error.xml    # XML intencionalmente incorrecto (prueba DTD)
├── css/
│   └── estilo.css         # Hoja de estilos para el HTML generado
├── json/
│   └── datos.json         # Equivalente JSON del XML
└── docs/
    ├── validacion_dtd.png     # Evidencia validación correcta
    ├── error_dtd.png          # Evidencia detección de errores
    ├── transform_html.png     # Evidencia transformación XSLT
    └── Informe.md             # Este documento
```

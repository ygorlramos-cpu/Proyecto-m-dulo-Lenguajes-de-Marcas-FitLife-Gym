# 💪 FitLife Gym — Lenguajes de Marcas y SGI

Módulo **0373 - Lenguajes de Marcas y Sistemas de Gestión de Información**  
Proyecto Intermodular · FitLife Gym

---

## 📋 Descripción

Este módulo gestiona y valida la información estructurada del gimnasio **FitLife Gym** mediante XML, DTD, XSLT y JSON.

El sistema representa:
- **Socios** — datos personales, membresía y estado
- **Entrenadores** — especialidad y datos de contacto
- **Clases** — tipo, horario, aforo y precio

---

## 📁 Estructura del proyecto

```
fitlife/
├── xml/
│   ├── datos.xml           # XML principal con datos del gimnasio
│   ├── modelo.dtd          # DTD que valida la estructura del XML
│   ├── transform.xsl       # Transformación XSLT → HTML
│   └── datos_error.xml     # XML incorrecto para probar el DTD
├── css/
│   └── estilo.css          # Estilos del informe HTML
├── json/
│   └── datos.json          # Equivalente JSON del XML
└── docs/
    ├── Informe.md          # Documentación técnica
    ├── validacion_dtd.png  # Captura validación correcta
    ├── error_dtd.png       # Captura detección de errores
    └── transform_html.png  # Captura HTML generado
```

---

## ✅ Validar el XML con el DTD

```bash
xmllint --noout --dtdvalid xml/modelo.dtd xml/datos.xml
```
> Sin salida = validación correcta ✅

```bash
xmllint --noout --dtdvalid xml/modelo.dtd xml/datos_error.xml
```
> Muestra 3 errores = el DTD controla correctamente ❌

---

## 🔄 Generar el HTML desde el XSLT

```bash
xsltproc xml/transform.xsl xml/datos.xml > docs/informe.html
```

O usando Saxon:
```bash
java -jar saxon-he.jar -s:xml/datos.xml -xsl:xml/transform.xsl -o:docs/informe.html
```

Abrir `docs/informe.html` en el navegador para ver el informe completo.

---

## 🔗 Integración con el proyecto

| Tipo | Descripción |
|---|---|
| **Exportación** | La app exporta datos de la BBDD a `datos.xml` y `datos.json` |
| **Reporte** | El XML + XSLT genera un informe HTML navegable |
| **Importación** | El JSON permite importar datos iniciales a la app |

---

## 🛠️ Tecnologías usadas

![XML](https://img.shields.io/badge/XML-orange?style=flat)
![DTD](https://img.shields.io/badge/DTD-blue?style=flat)
![XSLT](https://img.shields.io/badge/XSLT-green?style=flat)
![JSON](https://img.shields.io/badge/JSON-yellow?style=flat)
![CSS](https://img.shields.io/badge/CSS3-purple?style=flat)

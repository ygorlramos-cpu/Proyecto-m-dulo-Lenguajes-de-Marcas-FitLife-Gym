<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"
    doctype-public="-//W3C//DTD HTML 4.01//EN"/>

  <!-- ==================== PLANTILLA RAÍZ ==================== -->
  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>FitLife Gym - Informe de Gestión</title>
        <link rel="stylesheet" href="../css/estilo.css"/>
      </head>
      <body>

        <!-- PORTADA -->
        <header class="portada">
          <div class="logo-area">
            <h1>💪 FitLife Gym</h1>
            <p class="subtitulo">Sistema de Gestión de Información</p>
          </div>
          <div class="fecha-generacion">
            <p>Informe generado: <strong>Mayo 2025</strong></p>
            <p>Gimnasio: <strong><xsl:value-of select="gimnasio/@nombre"/></strong></p>
          </div>
        </header>

        <!-- NAVEGACIÓN -->
        <nav class="navegacion">
          <a href="#socios">👥 Socios</a>
          <a href="#entrenadores">🏋️ Entrenadores</a>
          <a href="#clases">📋 Clases</a>
          <a href="#resumen">📊 Resumen</a>
        </nav>

        <main>

          <!-- SECCIÓN: SOCIOS -->
          <section id="socios">
            <h2>👥 Socios</h2>

            <!-- Socios Activos -->
            <h3>Socios Activos</h3>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Email</th>
                  <th>Teléfono</th>
                  <th>Membresía</th>
                  <th>Fecha Alta</th>
                  <th>Clases</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="gimnasio/socios/socio[@estado='activo']">
                  <tr>
                    <td><span class="id-badge"><xsl:value-of select="@id"/></span></td>
                    <td><strong><xsl:value-of select="nombre"/></strong></td>
                    <td><xsl:value-of select="email"/></td>
                    <td><xsl:value-of select="telefono"/></td>
                    <td>
                      <span>
                        <xsl:attribute name="class">
                          membresia-<xsl:value-of select="tipo_membresia"/>
                        </xsl:attribute>
                        <xsl:value-of select="tipo_membresia"/>
                      </span>
                    </td>
                    <td><xsl:value-of select="fecha_alta"/></td>
                    <td><xsl:value-of select="count(inscripciones/inscripcion)"/></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>

            <!-- Socios con otros estados -->
            <h3>Socios Inactivos / Suspendidos</h3>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Email</th>
                  <th>Estado</th>
                  <th>Membresía</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="gimnasio/socios/socio[@estado!='activo']">
                  <tr>
                    <td><span class="id-badge"><xsl:value-of select="@id"/></span></td>
                    <td><xsl:value-of select="nombre"/></td>
                    <td><xsl:value-of select="email"/></td>
                    <td>
                      <span>
                        <xsl:attribute name="class">
                          estado-<xsl:value-of select="@estado"/>
                        </xsl:attribute>
                        <xsl:value-of select="@estado"/>
                      </span>
                    </td>
                    <td><xsl:value-of select="tipo_membresia"/></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </section>

          <!-- SECCIÓN: ENTRENADORES -->
          <section id="entrenadores">
            <h2>🏋️ Entrenadores</h2>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Email</th>
                  <th>Teléfono</th>
                  <th>Especialidad</th>
                  <th>Fecha Contrato</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="gimnasio/entrenadores/entrenador">
                  <tr>
                    <td><span class="id-badge"><xsl:value-of select="@id"/></span></td>
                    <td><strong><xsl:value-of select="nombre"/></strong></td>
                    <td><xsl:value-of select="email"/></td>
                    <td><xsl:value-of select="telefono"/></td>
                    <td>
                      <span class="especialidad">
                        <xsl:value-of select="@especialidad"/>
                      </span>
                    </td>
                    <td><xsl:value-of select="fecha_contrato"/></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </section>

          <!-- SECCIÓN: CLASES -->
          <section id="clases">
            <h2>📋 Clases</h2>

            <h3>Clases Activas</h3>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Tipo</th>
                  <th>Día</th>
                  <th>Horario</th>
                  <th>Aforo</th>
                  <th>Precio/mes</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="gimnasio/clases/clase[@estado='activa']">
                  <tr>
                    <td><span class="id-badge"><xsl:value-of select="@id"/></span></td>
                    <td><strong><xsl:value-of select="nombre"/></strong></td>
                    <td><span class="tipo-clase"><xsl:value-of select="@tipo"/></span></td>
                    <td><xsl:value-of select="horario/@dia"/></td>
                    <td>
                      <xsl:value-of select="horario/@hora_inicio"/> -
                      <xsl:value-of select="horario/@hora_fin"/>
                    </td>
                    <td><xsl:value-of select="aforo_maximo"/> personas</td>
                    <td><strong><xsl:value-of select="precio_mensual"/>€</strong></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>

            <h3>Clases Canceladas / Completas</h3>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Estado</th>
                  <th>Tipo</th>
                  <th>Día</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="gimnasio/clases/clase[@estado!='activa']">
                  <tr>
                    <td><span class="id-badge"><xsl:value-of select="@id"/></span></td>
                    <td><xsl:value-of select="nombre"/></td>
                    <td>
                      <span>
                        <xsl:attribute name="class">estado-<xsl:value-of select="@estado"/></xsl:attribute>
                        <xsl:value-of select="@estado"/>
                      </span>
                    </td>
                    <td><xsl:value-of select="@tipo"/></td>
                    <td><xsl:value-of select="horario/@dia"/></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </section>

          <!-- SECCIÓN: RESUMEN -->
          <section id="resumen">
            <h2>📊 Resumen del Gimnasio</h2>
            <div class="cards-resumen">
              <div class="card">
                <h4>Total Socios</h4>
                <p class="numero"><xsl:value-of select="count(gimnasio/socios/socio)"/></p>
              </div>
              <div class="card">
                <h4>Socios Activos</h4>
                <p class="numero"><xsl:value-of select="count(gimnasio/socios/socio[@estado='activo'])"/></p>
              </div>
              <div class="card">
                <h4>Total Clases</h4>
                <p class="numero"><xsl:value-of select="count(gimnasio/clases/clase)"/></p>
              </div>
              <div class="card">
                <h4>Entrenadores</h4>
                <p class="numero"><xsl:value-of select="count(gimnasio/entrenadores/entrenador)"/></p>
              </div>
            </div>
          </section>

        </main>

        <footer>
          <p>FitLife Gym © 2025 — Informe generado automáticamente mediante XSLT</p>
          <p><a href="#socios">↑ Volver arriba</a></p>
        </footer>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

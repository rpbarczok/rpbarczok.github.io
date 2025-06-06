<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl">

  <xsl:output method="html" />

  <!-- Witness and Font: Import from JavaScript -->
  <xsl:param name="witness" />

  <xsl:param name="font" />

  <xsl:param name="nrwitness" select="concat('#', $witness)" />

  <xsl:param name="fontstyle"
    select="concat('text-align: justify; direction: rtl; font-size:2em; font-family:', $font, ';')" />

  <xsl:param name="fontstyle2"
    select="concat('text-align: justify; direction: ltr; font-size:2em; font-family:', $font, ';')" />

  <xsl:param name="apos">'</xsl:param>

  <xsl:param name="jsms" select="concat('displayResult(this.value,', $apos, $font, $apos, ')')" />

  <xsl:param name="jsfont" select="concat('displayResult(', $apos, $witness, $apos, ',this.value)')" />


  <!-- Variable: Xml-file is flattened for further processing -->
  <xsl:variable name="flattened">
    <xsl:apply-templates select="tei:TEI/tei:text" mode="stage1" />
  </xsl:variable>

  <!-- Template: template for flattened-variable for variable -->
  <xsl:template match="tei:div1 | tei:p" mode="stage1">
    <xsl:for-each select="node() | @*">
      <xsl:choose>
        <xsl:when test="name()='div1'">
          <xsl:apply-templates select="." mode="stage1" />
        </xsl:when>
        <xsl:when
          test="name()='p' and ((count(preceding::tei:witStart/..[@wit=$nrwitness]) + count(preceding::tei:witEnd/..[@wit=$nrwitness]) + count(preceding::tei:lacunaStart/..[@wit=$nrwitness]) + count(preceding::tei:lacunaEnd/..[@wit=$nrwitness])) mod 2 = 1)">
          <xsl:apply-templates select="." mode="stage1" />
          <br />
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="." />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- Template 1: Gesamtdokument -->
  <xsl:template match="/">
    <header
      style="background-image:url('/pictures/busnaya_snippet40.png');  background-size: cover; height:200px; padding-top: 35px; padding-left: 10px;">
      <h2>
        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/." />
      </h2>
      <h3> by <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/." />
      </h3>
    </header>
    <main>
      <div class="w3-container w3-light-gray">
        <div class="w3-panel">
          <select id="witness" name="witness">
            <xsl:attribute name="onchange">
              <xsl:value-of select="$jsms" />
            </xsl:attribute>
            <xsl:for-each
              select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness">
              <option>
                <xsl:attribute name="value">
                  <xsl:value-of select="./@xml:id" />
                </xsl:attribute>
                <xsl:if
                  test="./@xml:id = $witness">
                  <xsl:attribute name="selected">
                    selected
                  </xsl:attribute>
                </xsl:if>
                <xsl:value-of
                  select="./@xml:id" /> = <xsl:value-of
                  select="tei:msDesc/tei:msIdentifier/tei:settlement/." />, <xsl:value-of
                  select="tei:msDesc/tei:msIdentifier/tei:repository/." />, <xsl:value-of
                  select="tei:msDesc/tei:msIdentifier/tei:idno/." />
              </option>
            </xsl:for-each>
          </select>
        </div>
        <div>
          <ul>
            <xsl:for-each
              select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness">
              <li>
                <xsl:value-of select="./@xml:id" /> = <xsl:value-of
                  select="tei:msDesc/tei:msIdentifier/tei:settlement/." />, <xsl:value-of
                  select="tei:msDesc/tei:msIdentifier/tei:repository/." />, <xsl:value-of
                  select="tei:msDesc/tei:msIdentifier/tei:idno/." />
              </li>
            </xsl:for-each>
          </ul>
        </div>
        <div class="w3-panel">
          <div class="w3-row">
            <div class="w3-col s1 w3-padding">
            </div>
            <div class="w3-col s11 w3-padding">

              <select id="font" name="font">
                <xsl:attribute name="onchange">
                  <xsl:value-of select="$jsfont" />
                </xsl:attribute>
                <option value="EastSyriacAdiabene">
                  <xsl:if test="$font='EastSyriacAdiabene'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  East Syriac Adiabene </option>
                <option value="EastSyriacCtesiphon">
                  <xsl:if test="$font='EastSyriacCtesiphon'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  East Syriac Ctesiphon </option>
                <option value="EstrangeloAntioch">
                  <xsl:if test="$font='EstrangeloAntioch'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Estrangelo Antioch </option>
                <option value="EstrangeloEdessa">
                  <xsl:if test="$font='EstrangeloEdessa'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Estrangelo Edessa </option>
                <option value="EstrangeloMidyat">
                  <xsl:if test="$font='EstrangeloMidyat'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Estrangelo Midyat </option>
                <option value="EstrangeloNisibin">
                  <xsl:if test="$font='EstrangeloNisibin'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Estrangelo Nisibin </option>
                <option value="EstrangeloQuenneshrin">
                  <xsl:if test="$font='EstrangeloQuenneshrin'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Estrangelo Quenneshrin </option>
                <option value="EstrangeloTalada">
                  <xsl:if test="$font='EstrangeloTalada'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Estrangelo Talada </option>
                <option value="EstrangeloTurAbdin">
                  <xsl:if test="$font='EstrangeloTurAbdin'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Estrangelo TurAbdin </option>
                <option value="SertoBatnan">
                  <xsl:if test="$font='SertoBatnan'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Serto Batnan </option>
                <option value="SertoJerusalem">
                  <xsl:if test="$font='SertoJerusalem'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Serto Jerusalem </option>
                <option value="SertoKharput">
                  <xsl:if test="$font='SertoKharput'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Serto Kharput </option>
                <option value="SertoMalankara">
                  <xsl:if test="$font='SertoMalankara'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Serto Malankara </option>
                <option value="SertoMardin">
                  <xsl:if test="$font='SertoMardin'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Serto Mardin </option>
                <option value="SertoUrhoy">
                  <xsl:if test="$font='SertoUrhoy'">
                    <xsl:attribute name="selected">
                      selected
                    </xsl:attribute>
                  </xsl:if>
                  Serto Urhoy </option>
              </select>
            </div>
          </div>
        </div>
      </div>
      <div class="w3-panel">
        <div class="w3-row">
          <div class="w3-col s1 w3-padding">
          </div>
          <div class="w3-col s11 w3-padding"> To see the critical apparatus with all variants, click
            on the marked text passages between <bold>˹</bold> and <bold>˺</bold> or on <bold>*</bold>
            . </div>
        </div>
      </div>
      <div class="w3-row">
        <div class="w3-col s1 w3-padding">
        </div>
        <div class="w3-col s8 w3-card-4 w3-white w3-padding">
          <xsl:attribute name="style">
            <xsl:value-of select="$fontstyle" />
          </xsl:attribute>

          <xsl:apply-templates select="exsl:node-set($flattened)/node()" />

        </div>

        <div class="w3-col s3"
          style="border: 3px solid; background-color: white; position: fixed; right: 0; top: 25%;">
          Critical Apparatus: <xsl:for-each select="//tei:app">
            <div id="{generate-id()}" class="w3-panel w3-display-container critapp"
              style="display:none;">
              <span onclick="this.parentElement.style.display='none'" class="w3-display-topright">
                X
              </span>
              <xsl:choose>

                <xsl:when test="./tei:rdg/tei:lacunaStart">
                  <xsl:for-each select="tei:rdg">
                    <xsl:value-of select="@wit" />: Lacuna starts. </xsl:for-each>
                </xsl:when>

                <xsl:when test="./tei:rdg/tei:lacunaEnd">
                  <xsl:for-each select="tei:rdg">
                    <xsl:value-of select="@wit" />: Lacuna ends. <br />
                  </xsl:for-each>
                </xsl:when>

                <xsl:when test="./tei:rdg/tei:witEnd">
                  <xsl:for-each select="tei:rdg">
                    <xsl:value-of select="@wit" /> ends. <br />
                  </xsl:for-each>
                </xsl:when>
                <xsl:when test="./tei:rdg/tei:witStart">
                  <xsl:for-each select="tei:rdg">
                    <xsl:value-of select="@wit" /> starts. <br />
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <!-- If the the reading of the choosen manuscript is part of Lem-->
                    <xsl:when test="tei:lem[contains(@wit, $witness)]">
                      <p>
                        <xsl:attribute name="style">
                          <xsl:value-of select="$fontstyle" />
                        </xsl:attribute>
                        <xsl:apply-templates
                          select="tei:lem" mode="app1" /> ] <br />
                      </p>
                      <hr />
                      <span>
                        <xsl:attribute name="style">
                          <xsl:value-of select="$fontstyle2" />
                        </xsl:attribute>
                        <xsl:apply-templates select="tei:rdg" mode="app2" />
                      </span>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:for-each select="tei:rdg">
                        <xsl:if test="contains(@wit, $witness)">
                          <p>
                            <xsl:attribute name="style">
                              <xsl:value-of select="$fontstyle" />
                            </xsl:attribute>
                            <xsl:apply-templates
                              select="tei:rdg" mode="app1" /> ] <br />
                          </p>
                          <hr />
                          <span>
                            <xsl:attribute name="style">
                              <xsl:value-of select="$fontstyle2" />
                            </xsl:attribute>
                            <xsl:apply-templates select="tei:rdg" mode="app2" />
                          </span>
                        </xsl:if>
                      </xsl:for-each>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </xsl:for-each>
        </div>
      </div>
    </main>
    <footer class="w3-container w3-gray">
      <hr />
    </footer>
  </xsl:template>


  <!-- lacuna text -->
  <xsl:template match="text()">
    <xsl:if
      test="((count(preceding::tei:witStart/..[@wit=$nrwitness]) + count(preceding::tei:witEnd/..[@wit=$nrwitness]) + count(preceding::tei:lacunaStart/..[@wit=$nrwitness]) + count(preceding::tei:lacunaEnd/..[@wit=$nrwitness])) mod 2 = 1)">
      <xsl:value-of select="." />
    </xsl:if>
  </xsl:template>


  <!-- Template: Überschriften -->
  <xsl:template match="tei:head">
    <span style="color:red;">
      <xsl:apply-templates select="node()" />
      <xsl:if
        test="((count(preceding::tei:witStart/..[@wit=$nrwitness]) + count(preceding::tei:witEnd/..[@wit=$nrwitness]) + count(preceding::tei:lacunaStart/..[@wit=$nrwitness]) + count(preceding::tei:lacunaEnd/..[@wit=$nrwitness])) mod 2 = 1)">
        <br />
      </xsl:if>
    </span>
  </xsl:template>

  <!-- Template pages -->
  <xsl:template match="tei:pb">
    <xsl:if test="contains(@wit, $witness)"> [<xsl:value-of select="@n" />] </xsl:if>
  </xsl:template>

  <!-- Template em -->
  <xsl:template match="tei:em">
    <span class="em">
      <xsl:apply-templates select="node()" />
    </span>
  </xsl:template>

  <!-- Template del -->
  <xsl:template match="tei:del">
    <del>
      <xsl:value-of select="." />
    </del>
  </xsl:template>

  <!-- Template add -->
  <xsl:template match="tei:add"> [<xsl:value-of select="." />] </xsl:template>

  <!-- Template gap -->
  <xsl:template match="tei:gap">
    [...]
  </xsl:template>

  <xsl:template match="tei:app">
    <xsl:choose>
      <xsl:when test="tei:lem[contains(@wit, $witness)]">
        <a class="app" onclick="showApp('{generate-id()}');">
          <xsl:apply-templates select="tei:lem" />
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="tei:rdg">
          <xsl:if test="contains(@wit, $witness)">
            <xsl:choose>
              <xsl:when test="child::tei:lacunaStart">
                [...lacuna...]
              </xsl:when>
              <xsl:when test="child::tei:lacunaEnd">
              </xsl:when>
              <xsl:when test="child::tei:witStart"> [<xsl:value-of select="$witness" /> starts] <br />
              </xsl:when>
              <xsl:when test="child::tei:witEnd">
                <br /> [<xsl:value-of select="$witness" /> ends] </xsl:when>
              <xsl:otherwise>
                <a class="app" onclick="showApp('{generate-id()}');">
                  <xsl:apply-templates select="tei:rdg" />
                </a>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:lem">
    <xsl:choose>
      <xsl:when test="text() != ''">
        <strong>
          ˺
        </strong>
        <xsl:apply-templates select="node()" />
        <strong>
          ˹
        </strong>
      </xsl:when>
      <xsl:otherwise>
        *
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:rdg">
    <xsl:choose>
      <xsl:when test="text() != ''">
        <strong>
          ˺
        </strong>
        <xsl:apply-templates select="node()" />
        <strong>
          ˹
        </strong>
      </xsl:when>
      <xsl:otherwise>
        *
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="tei:lem" mode="app1">
    <xsl:if test="text() != ''">
      <xsl:apply-templates select="node()" />
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:rdg" mode="app1">
    <xsl:if test="text() != ''">
      <xsl:apply-templates select="node()" />
    </xsl:if>
  </xsl:template>


  <xsl:template match="tei:lem" mode="app2">
    <xsl:value-of select="@wit" /> : <xsl:choose>
      <xsl:when test="text() != ''">
        <p style="direction: rtl;">
          <xsl:apply-templates select="node()" />
        </p>
      </xsl:when>
      <xsl:when test="./@type='nonlegible'"> [...] <br />
      </xsl:when>
      <xsl:otherwise> om. <br />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:rdg" mode="app2">
    <xsl:value-of select="@wit" /> : <xsl:choose>
      <xsl:when test="text() != ''">
        <p style="direction: rtl;">
          <xsl:apply-templates select="node()" />
        </p>
      </xsl:when>
      <xsl:when test="./@type='nonlegible'"> [...] <br />
      </xsl:when>
      <xsl:otherwise> om. <br />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


</xsl:transform>
<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl">

<xsl:import href="exsl.xsl" />

  <xsl:output method="html" />

  <!-- Variablen -->
  <!-- Witness and Font: Import from JavaScript -->
  <xsl:param name="witness" />

  <xsl:param name="font"/>

  <xsl:param name="nrwitness" select="concat('#', $witness)"/>

  <xsl:param name="fontstyle" select="concat('text-align: justify; direction: rtl; font-size:2em; font-family:', $font, ';')"/>

  <xsl:param name="fontstyle2" select="concat('text-align: justify; direction: ltr; font-size:2em; font-family:', $font, ';')"/>

  <xsl:param name="apos">'</xsl:param>

  <xsl:param name="jsms" select="concat('displayResult(this.value,', $apos, $font, $apos, ')')"/>

  <xsl:param name="jsfont" select="concat('displayResult(', $apos, $witness, $apos, ',this.value)')"/>

  <!-- Variable: Xml-file is flattened for further processing -->
  <xsl:variable name="flattened">
    <xsl:apply-templates select="tei:TEI/tei:text" mode="stage1"/>
  </xsl:variable>

  <!-- Template: template for flattened-variable for variable -->
  <xsl:template match="tei:div1 | tei:p" mode="stage1">
    <xsl:for-each select="node() | @*">
      <xsl:choose>
        <xsl:when test="name()='div1'">
          <xsl:apply-templates select="." mode="stage1"/>
        </xsl:when>
        <xsl:when test="name()='p' and ((count(preceding::tei:witStart/..[@wit=$nrwitness]) + count(preceding::tei:witEnd/..[@wit=$nrwitness]) + count(preceding::tei:lacunaStart/..[@wit=$nrwitness]) + count(preceding::tei:lacunaEnd/..[@wit=$nrwitness])) mod 2 = 1)">
          <xsl:apply-templates select="." mode="stage1"/>
          <br/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- Template 1: Gesamtdokument -->
  <xsl:template match="/">
    <header style="background-image:url('/pictures/busnaya_snippet40.png');  background-size: cover; height:200px; padding-top: 35px; padding-left: 10px;">
      <h2>
        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/."/>
      </h2>
      <h3>
        by 
        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/."/>
      </h3>
    </header>

    <main>
      <div class="w3-container w3-light-gray">
        <div class ="w3-panel">
          <select id="witness" name="witness" onchange="displayResult(this.value)">
            <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness">
              <option>
                <xsl:attribute name="value">
                  <xsl:value-of select="./@xml:id"/>
                </xsl:attribute>
                <xsl:if test="./@xml:id = $witness">
                  <xsl:attribute name="selected">
                    selected
                  </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="./@xml:id"/>  =
                <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:settlement/."/>,
                <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:repository/."/>,
                <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:idno/."/>, part of the
                <xsl:value-of select="../tei:head/text()"/>
              </option>
            </xsl:for-each>
          </select>
        </div>
        <div>
          <ul>
            <xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness">
              <li>
                <xsl:value-of select="./@xml:id"/> =
                <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:settlement/."/>,
                <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:repository/."/>,
                <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:idno/."/>
              </li>
            </xsl:for-each>
          </ul>
        </div>
      </div>
      <div>
        <div class="w3-panel">
          <div class="w3-row">
            <div class="w3-col s1 w3-padding">
            </div>
            <div class="w3-col s11 w3-padding">
              <select id="font" name="font">
	  	          <xsl:attribute name="onchange">
                <xsl:value-of select="$jsfont"/>
              </xsl:attribute>
              <option value="EastSyriacAdiabene">
                <xsl:if test="$font='EastSyriacAdiabene'">
                  <xsl:attribute name="selected">
                    selected
                  </xsl:attribute>
                </xsl:if>
                East Syriac Adiabene
              </option>
              <option value="EastSyriacCtesiphon">
                <xsl:if test="$font='EastSyriacCtesiphon'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                East Syriac Ctesiphon
              </option>
              <option value="EstrangeloAntioch">
                <xsl:if test="$font='EstrangeloAntioch'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Estrangelo Antioch
              </option>
              <option value="EstrangeloEdessa">
                <xsl:if test="$font='EstrangeloEdessa'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Estrangelo Edessa
              </option>
              <option value="EstrangeloMidyat">
                <xsl:if test="$font='EstrangeloMidyat'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Estrangelo Midyat
              </option>
              <option value="EstrangeloNisibin">
                <xsl:if test="$font='EstrangeloNisibin'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Estrangelo Nisibin
              </option>
              <option value="EstrangeloQuenneshrin">
                <xsl:if test="$font='EstrangeloQuenneshrin'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Estrangelo Quenneshrin
              </option>
              <option value="EstrangeloTalada">
                <xsl:if test="$font='EstrangeloTalada'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Estrangelo Talada
              </option>
              <option value="EstrangeloTurAbdin">
                <xsl:if test="$font='EstrangeloTurAbdin'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Estrangelo TurAbdin
              </option>
              <option value="SertoBatnan">
                <xsl:if test="$font='SertoBatnan'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Serto Batnan
              </option>
              <option value="SertoJerusalem">
                <xsl:if test="$font='SertoJerusalem'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Serto Jerusalem
              </option>
              <option value="SertoKharput">
                <xsl:if test="$font='SertoKharput'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Serto Kharput
              </option>
              <option value="SertoMalankara">
                <xsl:if test="$font='SertoMalankara'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Serto Malankara
              </option>
              <option value="SertoMardin">
                <xsl:if test="$font='SertoMardin'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Serto Mardin
              </option>
              <option value="SertoUrhoy">
                <xsl:if test="$font='SertoUrhoy'">
                    <xsl:attribute name="selected">
                    selected
                    </xsl:attribute>
                </xsl:if>
                Serto Urhoy
              </option>
            </select>    
          </div>
        </div>
      </div>
      <div class="w3-row">

        <div class="w3-col s1 w3-padding">
        </div>
        <div class="w3-col s8  w3-card-4 w3-white w3-padding">
          <xsl:attribute name="style">
            <xsl:value-of select="$fontstyle"/>
          </xsl:attribute>

          <xsl:apply-templates select="//tei:text"/>
        </div>        
        <div class="w3-col s1 w3-container">
        </div>
      </div>
    </main>

    <footer class="w3-container w3-gray">
      <hr/>
    </footer>
  </xsl:template>

  <xsl:template match="tei:text">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

</xsl:transform>
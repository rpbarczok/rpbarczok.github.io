<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:exsl="http://exslt.org/common"
    extension-element-prefixes="exsl">

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
    </main>

    <footer class="w3-container w3-gray">
      <hr/>
    </footer>
  </xsl:template>

</xsl:transform>
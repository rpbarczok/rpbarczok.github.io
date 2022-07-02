<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" />

  <!-- Variablen -->
  <!-- Witness: Import from JavaScript (cf. life.html) -->
  <xsl:param name="witness" />

  <xsl:param name="nrwitness" select="concat('#', $witness)"/>

  <xsl:variable name="witnessgroup">
    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness[@xml:id=$witness]/../@xml:id"/>
  </xsl:variable>

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
    <header class="w3-container w3-gray">
      <h2>
        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/."/>
      </h2>
      <h3>by <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/."/></h3>
    </header>
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
              <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:idno/."/>
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
      <div class="w3-row">
        <div class="w3-col s1 w3-container">

        </div>
        <div class="w3-col s10  w3-card-4 w3-white w3-padding selectableFont" style="direction: rtl; font-size: 2em; font-family: EastSyriacAdiabene;">
          <xsl:apply-templates select="."/>
        </div>
        <div class="w3-col s1 w3-container">

        </div>
      </div>
    </div>

    <footer class="w3-container w3-gray">
      <hr/>
    </footer>
  </xsl:template>

</xsl:transform>
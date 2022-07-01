
@@ -0,0 +1,240 @@
<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:exsl="http://exslt.org/common"
    extension-element-prefixes="exsl">

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
              <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:idno/."/>, part of the
              <xsl:value-of select="../tei:head/text()"/>
            </li>
          </xsl:for-each>
        </ul>
      </div>
      <div>
        <select id="selectFont" style="margin-top: 10px;">
           <option value="EastSyriacAdiabene">East Syriac Adiabene</option>
		      <option value="EastSyriacCtesiphon">East Syriac Ctesiphon</option>
      		<option value="EstrangeloAntioch">Estrangelo Antioch</option>
      		<option value="EstrangeloEdessa">Estrangelo Edessa</option>
      		<option value="EstrangeloMidyat">Estrangelo Midyat</option>
      		<option value="EstrangeloNisibin">Estrangelo Nisibin</option>
      		<option value="EstrangeloQuenneshrin">Estrangelo Quenneshrin</option>
      		<option value="EstrangeloTalada">Estrangelo Talada</option>
      		<option value="EstrangeloTurAbdin">Estrangelo TurAbdin</option>
      		<option value="SertoBatnan">Serto Batnan</option>
      		<option value="SertoJerusalem">Serto Jerusalem</option>
      		<option value="SertoKharput">Serto Kharput</option>
      		<option value="SertoMalankara">Serto Malankara</option>
      		<option value="SertoMardin">Serto Mardin</option>
      		<option value="SertoUrhoy">Serto Urhoy</option>
	</select>
  <script type="text/javascript">
    jQuery(document).ready(function() {
        $('#selectFont').val("EastSyriacAdiabene");
        $('#selectFont').on('change', function()
        {
            $('.selectableFont').not('.easternSyriac').css('font-family', $(this).val());
            $('span.ui-keyboard-text').css('font-family', $(this).val());
            var url = Routing.generate('set_session_fontface', { name: $(this).val() });
    		jQuery.ajax({ url: url });
		  });
      });
    </script>
      </div>
      <div class="w3-row">
        <div class="w3-col s1 w3-container">

        </div>
        <div class="w3-col s10  w3-card-4 w3-white w3-padding selectableFont" style="direction: rtl; font-size: 2em; font-family: EastSyriacAdiabene;">
          <xsl:apply-templates select="exsl:node-set($flattened)/node()"/>
        </div>
        <div class="w3-col s1 w3-container">

        </div>
      </div>
    </div>

    <footer class="w3-container w3-gray">
      <hr/>
    </footer>
  </xsl:template>

  <!-- Template: Überschriften -->
  <xsl:template match="tei:head">
    <span style="color:red;">
      <xsl:apply-templates select="node()"/>
    </span>
    <xsl:if test="((count(preceding::tei:witStart/..[@wit=$nrwitness]) + count(preceding::tei:witEnd/..[@wit=$nrwitness]) + count(preceding::tei:lacunaStart/..[@wit=$nrwitness]) + count(preceding::tei:lacunaEnd/..[@wit=$nrwitness])) mod 2 = 1)">
      <br/>
    </xsl:if>
  </xsl:template>

  <!-- lacuna text -->
  <xsl:template match="text()">
    <xsl:if test="((count(preceding::tei:witStart/..[@wit=$nrwitness]) + count(preceding::tei:witEnd/..[@wit=$nrwitness]) + count(preceding::tei:lacunaStart/..[@wit=$nrwitness]) + count(preceding::tei:lacunaEnd/..[@wit=$nrwitness])) mod 2 = 1)">
      <xsl:value-of select="."/>
    </xsl:if>
  </xsl:template>

  <!-- Template Paragragphes / br -->
  <xsl:template match="br">
    <br/>
  </xsl:template>

  <!-- Template pages -->

  <xsl:template match="tei:pb">
    <xsl:if test="contains(@wit, $witness)"> [<xsl:value-of select="@n"/>] </xsl:if>
  </xsl:template>

  <!-- Template del -->
  <xsl:template match="tei:del">
    <del><xsl:value-of select="."/></del>
  </xsl:template>

  <!-- Template add -->
  <xsl:template match="tei:add">
    [<xsl:value-of select="."/>]
  </xsl:template>

  <!-- Template Apparat -->
  <xsl:template match="tei:app">
    <xsl:for-each select="tei:rdg">
      <xsl:choose>
        <xsl:when test="(not(child::tei:witStart
                              or child::tei:lacunaStart
                              or child::tei:lacunaEnd
                              or child::tei:witEnd))">
          <!-- onclick="" necessary for iOS, so iPhones use "hover" instead of "click" handler -->
          <span class="w3-tooltip" onclick="">
            <strong>
              <xsl:if test="(contains(@wit, $witness) or contains(@wit, $witnessgroup))" >
                <xsl:choose>
                  <xsl:when test="text() != ' '">
                    <xsl:apply-templates select="node()"/>
                  </xsl:when>
                  <xsl:when test="./@type = 'nonlegible'">
                    [...]
                  </xsl:when>
                  <xsl:otherwise>
                    *
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </strong>
            <span class="w3-text w3-tag" style="direction: rtl; position:absolute; left:0; bottom:18px; width:200px;">
              <xsl:for-each select="../tei:rdg">
                <xsl:if test="not((contains(@wit, $witness)) or (contains(@wit, $witnessgroup)))">
                  <xsl:value-of select="./@wit"/>:
                  <xsl:choose>
                    <xsl:when test="text() != ' '">
                      <xsl:apply-templates select="node()"/>
                      <br/>
                    </xsl:when>
                    <xsl:when test="./@type='nonlegible'">
                      legi nequit
                      <br/>
                    </xsl:when>
                    <xsl:otherwise>
                      deest
                      <br/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
              </xsl:for-each>
            </span>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="(contains(@wit, $witness) or contains(@wit, $witnessgroup))" >
            <xsl:choose>
              <xsl:when test="child::tei:witStart">
                <strong style="font-family: Arial">
                  Ms <xsl:value-of select="$witness"/>
                  <br/>
                </strong>
              </xsl:when>
              <xsl:when test="child::tei:lacunaStart">
                [...lacuna...]
              </xsl:when>
            </xsl:choose>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
</xsl:transform>
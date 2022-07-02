<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" />

  <!-- Variables -->
  <!-- Witness and Font: Import from JavaScript -->
  <xsl:param name="witness" />

  <xsl:param name="font"/>

  <xsl:param name="nrwitness" select="concat('#', $witness)"/>

  <xsl:param name="fontstyle" select="concat('text-align: justify; direction: rtl; font-size:2em; font-family:', $font, ';')"/>

  <xsl:param name="fontstyle2" select="concat('text-align: justify; direction: ltr; font-size:2em; font-family:', $font, ';')"/>

  <xsl:param name="apos">'</xsl:param>

  <xsl:param name="jsms" select="concat('displayResult(this.value,', $apos, $font, $apos, ')')"/>

  <xsl:param name="jsfont" select="concat('displayResult(', $apos, $witness, $apos, ',this.value)')"/>

  <!-- Template 1: Gesamtdokument -->
  <xsl:template match="/">
    <header style="background-image:url('/pictures/busnaya_snippet40.png');  background-size: cover; height:200px; padding-top: 35px; padding-left: 10px;">
      <h2>
        13
        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/."/>
      </h2>
      <h3>
        by 
        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/."/>
      </h3>
    </header>
    <main>
      <div class="w3-container w3-light-gray">
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

        <div class="w3-col s8 w3-card-4 w3-white w3-padding">
          <xsl:attribute name="style">
            <xsl:value-of select="$fontstyle"/>
          </xsl:attribute>
        
          <xsl:apply-templates select="//tei:text"/>
        </div>
        
        <div class="w3-col s3" style="border: 3px solid; background-color: white; position: fixed; right: 0; top: 25%;">
          Critical Apparatus:
          <xsl:for-each select="//tei:app">
            <div id="{generate-id()}" class="w3-panel w3-display-container critapp" style="display:none;">
              <span onclick="this.parentElement.style.display='none'" class="w3-display-topright">
              X
              </span>
              

              <xsl:choose>
                <xsl:when test="./tei:rdg/tei:lacunaStart">
                  <xsl:for-each select="tei:rdg">
                    <xsl:value-of select="@wit"/>: Lacuna starts.
                  </xsl:for-each>
                </xsl:when>

                <xsl:when test="./tei:rdg/tei:lacunaEnd">
                  <xsl:for-each select="tei:rdg">
                    <xsl:value-of select="@wit"/>: Lacuna ends.
                    <br/>
                  </xsl:for-each>
                </xsl:when>
                
                <xsl:when test="./tei:rdg/tei:witEnd">
                  <xsl:for-each select="tei:rdg">
                    <xsl:value-of select="@wit"/> ends.
                    <br/>
                  </xsl:for-each>
                </xsl:when>
                
                <xsl:when test="./tei:rdg/tei:witStart">
                  <xsl:for-each select="tei:rdg">
                    <xsl:value-of select="@wit"/> starts.
                    <br/>
                  </xsl:for-each>
                </xsl:when>


                <xsl:otherwise>
                  <p>
                    <xsl:attribute name="style">
                      <xsl:value-of select="$fontstyle"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="tei:lem" mode="app"/>
                    ]
                    <br/>
                  </p>
                  <hr/>
                  <span>
                    <xsl:attribute name="style">
                      <xsl:value-of select="$fontstyle2"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="tei:rdg"/>
                  </span>
                </xsl:otherwise>
              </xsl:choose>

            </div>
          </xsl:for-each>        
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

<!-- Template paragraph-->
  <xsl:template match="tei:p">
    <p>
      <xsl:apply-templates select="node()"/>
    </p>
  </xsl:template>

	
<!-- Template head-->

  <xsl:template match="tei:head">
    <p class="head">
      <xsl:apply-templates select="node()"/>
    </p>
  </xsl:template>
  
  <!-- Template em -->
  <xsl:template match="tei:em">
    <span class="em">
      <xsl:apply-templates select="node()"/>
    </span>
  </xsl:template>

    <!-- Template del -->
  <xsl:template match="tei:del">
    <del><xsl:value-of select="."/></del>
  </xsl:template>

  <!-- Template add -->
  <xsl:template match="tei:add">
    [<xsl:value-of select="."/>]
  </xsl:template>
  
  <!-- Template gap -->
  <xsl:template match="tei:gap">
    [...]
  </xsl:template>

  <xsl:template match="tei:app">
    <xsl:choose>
      <xsl:when test="./tei:lem">
        <a class="app" onclick="showApp('{generate-id()}');">
          <xsl:apply-templates select="tei:lem"/>  
        </a> 
      </xsl:when>
      <xsl:when test="./tei:rdg/tei:lacunaStart">
        <a class="app" onclick="showApp('{generate-id()}');">
          *  
        </a>
      </xsl:when>
      <xsl:when test="./tei:rdg/tei:lacunaEnd">
        <a class="app" onclick="showApp('{generate-id()}');">
          *  
        </a>
      </xsl:when>
      <xsl:when test="./tei:rdg/tei:witStart">
        <a class="app" onclick="showApp('{generate-id()}');">
          *  
        </a>
      </xsl:when>
      <xsl:when test="./tei:rdg/tei:witEnd">
        <a class="app" onclick="showApp('{generate-id()}');">
          *  
        </a>
      </xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="tei:lem">

    <xsl:choose>
      <xsl:when test="text() != ''">
         <strong>
         ˺
         </strong>
         <xsl:apply-templates select="node()"/>
         <strong>
         ˹
         </strong>
      </xsl:when>
      <xsl:otherwise>
        *
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  
  <xsl:template match="tei:lem" mode="app">
    <xsl:if test="text() != ''">
      <xsl:apply-templates select="node()"/>
    </xsl:if>
  </xsl:template>


  <xsl:template match="tei:rdg">
    <xsl:value-of select="@wit"/>
    :
    <xsl:choose>
      <xsl:when test="text() != ''">
        <p style="direction: rtl;"><xsl:apply-templates select="node()"/></p>
      </xsl:when>
      <xsl:when test="./@type='nonlegible'">
        [...]
        <br/>
      </xsl:when>
      <xsl:otherwise>
        om.
        <br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:transform>

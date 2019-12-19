<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/TR/2004/REC-rdf-syntax-grammar-20040210/"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exist="http://exist.sourceforge.net/NS/exist" xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="tei mets xlink exist rdf" version="2.0">
    
    <xsl:import href="toc.xsl"/>

    <xsl:output encoding="UTF-8" indent="yes" method="html" doctype-public="-//W3C//DTD HTML 4.01//EN"
        doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <title>Görmar Familiengeschichte</title>
                <link rel="stylesheet" type="text/css" href="css/layout.css"/>
                <script type="text/javascript" src="jquery/jquery-1.11.0.js"/>
                <script type="text/javascript" src="jquery/functions.js"/>
            </head>
            <body>
                <header>
                    <p>Streifzüge durch die Geschichte der Familie Görmar in soundsovielen Objekten</p>
                </header>
                <xsl:call-template name="toc"/>
                <h1><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
                <div class="content">
                    <xsl:apply-templates select="//tei:div[@type='document']"/>
                </div>
                <xsl:if
                    test="tei:TEI/tei:text/tei:body/tei:div[@type='annotation']
                    | tei:TEI/tei:text/tei:body//tei:note[@type='annotation']
                    | tei:TEI/tei:text/tei:body//tei:note[@type='footnote']
                    | tei:TEI/tei:text/tei:body//tei:handShift
                    | tei:TEI/tei:text/tei:body//tei:choice">
                    <div id="annotation">
                        <!-- Textapparat  -->
                        <xsl:if
                            test="tei:TEI/tei:text/tei:body/tei:div[@type='annotation']
                            | tei:TEI/tei:text/tei:body//tei:note[@type='annotation']
                            | tei:TEI/tei:text/tei:body//tei:handShift
                            | tei:TEI/tei:text/tei:body//tei:choice">
                            <hr/>
                            <!-- 	                    <xsl:if test="tei:TEI/tei:text/tei:body/tei:div[@type='annotation'] | tei:TEI/tei:text/tei:body//tei:note[@type='annotation']"> -->
                            <div id="textapparat">Textapparat</div>
                            <!-- 	                    </xsl:if> -->
                            <!-- 	                    <div id="annotation_text"> -->
                            <!--                         <xsl:choose> -->
                            <!--                             <xsl:when -->
                            <xsl:if test="tei:TEI/tei:text/tei:body//tei:note[@type='textapparat']">
                                <!--  Wenn es eine Einleitung zum Textapparat gibt -->
                                <xsl:value-of select="tei:TEI/tei:text/tei:body//tei:note[@type='textapparat']"/>
                                <!--                             </xsl:when> -->
                                <!--                         </xsl:choose> -->
                            </xsl:if>
                            <xsl:choose>
                                <xsl:when test="tei:TEI/tei:text/tei:body/tei:div[@type='annotation']">
                                    <!--  Wenn es einen Fussnotenbereich gibt -->
                                    <xsl:apply-templates select="tei:TEI/tei:text/tei:body/tei:div[@type='annotation']"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <!--  andernfalls notes auswerten -->
                                    <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note[@type='annotation'] | //tei:handShift | //tei:choice |//tei:restore">
                                        <xsl:variable name="number">
                                            <xsl:call-template name="fnnumber" />
                                        </xsl:variable>
                                        <div style="padding-left: 1em; text-indent: -1em;">
                                            <a name="an{$number}" href="#ana{$number}" style="display:inline-block; margin-left: 1em; color:blue;">
                                                <xsl:value-of select="$number"/>
                                            </a>
                                            <xsl:text> </xsl:text>
                                            <xsl:choose>
                                                <xsl:when test="self::tei:note">
                                                    <xsl:apply-templates/>
                                                </xsl:when>
                                                <xsl:when test="self::tei:handShift">
                                                    <xsl:text>Schreiberwechsel zu </xsl:text>
                                                    <xsl:choose>
                                                        <xsl:when test="@scribe='chr'">
                                                            <i>Christian II</i>
                                                        </xsl:when>
                                                        <xsl:when test="@scribe='es'">
                                                            <i>Fürstin Eleonora Sophia von Anhalt-Bernburg</i>
                                                        </xsl:when>
                                                        <xsl:when test="@scribe">
                                                            <i><xsl:value-of select="@scribe" /></i>
                                                        </xsl:when>

                                                        <xsl:otherwise><i>unbekannt</i></xsl:otherwise>
                                                    </xsl:choose>
                                                    <xsl:text>.</xsl:text>
                                                </xsl:when>
                                                <xsl:when test="self::tei:choice">
                                                    <xsl:choose>
                                                        <xsl:when test="tei:corr">
                                                            <xsl:text>"</xsl:text>
                                                            <xsl:value-of select="tei:sic"/>
                                                            <xsl:text>"</xsl:text>
                                                            <xsl:text> im Original korrigiert in </xsl:text>
                                                            <xsl:text>"</xsl:text>
                                                            <xsl:value-of select="tei:corr"/>
                                                            <xsl:text>"</xsl:text>
                                                            <xsl:text>.</xsl:text>
                                                        </xsl:when>
                                                        <xsl:when test="tei:expan">
                                                            <xsl:text>"</xsl:text>
                                                            <xsl:value-of select="tei:abbr/text()"/>
                                                            <xsl:if test="tei:abbr/tei:c">
                                                                <xsl:if test="tei:abbr/tei:c/@rend='super'">
                                                                    <sup><xsl:value-of select="tei:abbr/tei:c"/></sup>
                                                                </xsl:if>
                                                            </xsl:if>
                                                            <xsl:text>"</xsl:text>
                                                            <xsl:text> im Original steht für </xsl:text>
                                                            <xsl:text>"</xsl:text>
                                                            <xsl:value-of select="tei:expan"/>
                                                            <xsl:text>"</xsl:text>
                                                            <xsl:text>.</xsl:text>
                                                        </xsl:when>
                                                    </xsl:choose>
                                                </xsl:when>
                                                <xsl:when test="self::tei:restore">
                                                    <xsl:text>Streichung von "</xsl:text>
                                                    <xsl:choose>
                                                        <xsl:when test="child::tei:foreign">
                                                            <xsl:value-of select="text()"/>
                                                            <xsl:value-of select="tei:foreign"/>
                                                        </xsl:when>
                                                        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                                                    </xsl:choose>
                                                    <xsl:text>" wieder aufgehoben.</xsl:text>
                                                </xsl:when>
                                            </xsl:choose>
                                        </div>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>

                        <!-- Kommentare  -->
                        <xsl:if test="tei:TEI/tei:text/tei:body//tei:note[@type='footnote'] | tei:TEI/tei:text/tei:body//tei:ref[@type='biblical'][@cRef][not(ancestor::tei:note)]">
                            <hr/>
                            
                            <div id="textapparat">Kommentar</div>
                            <xsl:choose>
                                <xsl:when test="tei:TEI/tei:text/tei:body//tei:note[@type='commentar']">
                                    <!--  Wenn es eine Einleitung zum Kommentar gibt -->
                                    <xsl:value-of select="tei:TEI/tei:text/tei:body//tei:note[@type='commentar']"/>
                                </xsl:when>
                                <xsl:when test="tei:TEI/tei:text/tei:body/tei:div/tei:note[@type='commentar']">
                                    <!--  Wenn es eine Einleitung zum Kommentar gibt -->
                                    <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:div/tei:note[@type='commentar']"/>
                                </xsl:when>
                                <xsl:otherwise> </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="tei:TEI/tei:text/tei:body/tei:div[@type='footnotes']">
                                    <!--  Wenn es einen Fussnotenbereich gibt -->
                                    <xsl:apply-templates select="tei:TEI/tei:text/tei:body/tei:div[@type='footnotes']"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <!--  andernfalls notes auswerten -->
                                    <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note[@type='footnote'] | tei:TEI/tei:text/tei:body//tei:ref[@type='biblical'][@cRef][not(ancestor::tei:note)]">
                                        <xsl:variable name="number">
                                            <xsl:number level="any" count="tei:note[@type ='footnote'] | tei:ref[@type='biblical'][@cRef][not(ancestor::tei:note)]"/>
                                        </xsl:variable>
                                        <div style="padding-left: 1em; text-indent: -1em;">
                                            <a name="fn{$number}" href="#fna{$number}" style="display:inline-block; margin-left: 1em;">
                                                <xsl:if test="@xml:id">
                                                    <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="$number"/>
                                            </a>
                                            <xsl:text> </xsl:text>
                                            <xsl:choose>
                                                <xsl:when test="self::tei:ref[@type='biblical'][@cRef][not(ancestor::tei:note)]">
                                                    <xsl:choose>
                                                        <xsl:when test="starts-with(@cRef, '1') or starts-with(@cRef, '2') or starts-with(@cRef, '3') or starts-with(@cRef, '4')">
                                                            <xsl:value-of select="substring-before(@cRef, '_')"/>
                                                            <xsl:text>. </xsl:text>
                                                            <xsl:value-of select="substring-before(substring-after(@cRef, '_'), '_')"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="substring-after(substring-after(@cRef, '_'), '_')"/>
                                                            <xsl:text>.</xsl:text>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:choose>
                                                                <xsl:when test="contains(@cRef, '_')">
                                                                    <xsl:value-of select="substring-before(@cRef, '_')"/>
                                                                    <xsl:text> </xsl:text>
                                                                    <xsl:value-of select="substring-after(@cRef, '_')"/>
                                                                    <xsl:text>.</xsl:text>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="@cRef"/>
                                                                    <xsl:text>.</xsl:text>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:apply-templates/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                    </div>
                </xsl:if>
                <div id="info_person">
                    <xsl:apply-templates select="//tei:person"/>
                </div>
                <div id="info_place">
                    <xsl:apply-templates select="//tei:place"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:p">
        <p>
            <xsl:if test="@rendition='#c'">
                <xsl:attribute name="class">
                    <xsl:text>center</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:pb">
        <xsl:text>[</xsl:text>
        <a class="pb" href="images/{@facs}.JPG" target="_blank">[<xsl:value-of select="@n"/>]</a>
        <xsl:text>]</xsl:text>
    </xsl:template>

    <xsl:template match="tei:lb[not(ancestor::tei:add)]">
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:lb[ancestor::tei:add]"/>

    <xsl:template match="tei:figure">
        <div class="imagecontainer">
            <img src="{tei:graphic/@url}" alt="Bild: {tei:head}"/>
        </div>
    </xsl:template>
    <xsl:template match="tei:figure/tei:head"/>

    <xsl:template match="tei:add">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:hi[@rendition]|tei:rs/tei:hi">
        <xsl:if test="@rendition='#c'">
            <span class="center">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rendition='#sup'">
            <span class="superscript">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rendition='#et'">
            <span class="indent">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rendition='underline'">
            <span class="underline">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rendition='underline #et'">
            <span class="underline indent">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rendition='#right'">
            <span class="right-align">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rendition='bold'">
            <span class="bold">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
    </xsl:template>

    <xsl:template name="fnnumber">
        <xsl:number level="any" format="a" count="//tei:note[@type='annotation'] | //tei:handShift | //tei:choice | //tei:restore"/>
    </xsl:template>

    <xsl:template match="tei:note">
		<xsl:param name="caption"/>
		<!--  zwei Typen: entweder Fussnoten am Text- oder Seitenende in einem besonderen Abschnitt oder in den Text integriert -->
		<xsl:choose>
			<xsl:when test="parent::tei:div[@type='footnotes' ]">
				<!--   Fussnoten am Text- oder Seitenende -->
				<div class="footnotes">
					<a name="fn{@n}" href="#fna{@n}" style="font-size:9pt;vertical-align:super;color:blue;margin-right:0.3em;">
						<xsl:value-of select="@n"/>
					</a>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:when test="$caption ='true'">
				<!-- keine Anzeige -->
			</xsl:when>
			<xsl:when test="@type='footnoteX'">
				<!--  noch in Bearbeitung, nicht anzeigen -->
			</xsl:when>
			<xsl:when test="@type='footnote'">
				<xsl:variable name="number">
					<xsl:number level="any" count="tei:note[@type ='footnote'] | tei:ref[@type='biblical'][not(ancestor::tei:note)]"/>
				</xsl:variable>
				<!--  in Text integriert, nur Verweis , Fussnotenabschnitt mit foreach generiert -->
				<xsl:choose>
					<xsl:when test="..//tei:ref[@type='biblical'][not(ancestor::tei:note)]">
						<a name="fna{$number}" href="#fn{$number}" title="{normalize-space(.)}" style="font-size:9pt;vertical-align:super;color:blue;">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$caption"/>
							<xsl:value-of select="$number"/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<a name="fna{$number}" href="#fn{$number}" title="{normalize-space(.)}" style="font-size:9pt;vertical-align:super;color:blue;">
							<xsl:value-of select="$caption"/>
							<xsl:value-of select="$number"/>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@type='annotation'">
				<xsl:variable name="number">
					<xsl:call-template name="fnnumber" />
				</xsl:variable>
				<!--  in Text integriert, nur Verweis , Fussnotenabschnitt mit foreach generiert -->
				<a name="ana{$number}" href="#an{$number}" title="{normalize-space(.)}" style="font-size:9pt;vertical-align:super;color:blue;">
					<xsl:value-of select="$number" />
				</a>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:closer">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:opener">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:salute">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:stamp">
        <xsl:text>[Stempel:]</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:person">
        <xsl:call-template name="format-person"/>
    </xsl:template>
    
    <xsl:template name="format-person">
        <div id="{@xml:id}">
            <xsl:attribute name="class">
                <xsl:text>rs-ref</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="tei:persName">
                <div>
                    <!-- Vorname -->
                    <xsl:if test="tei:forename">
                        <span class="forename">
                            <b>
                                <xsl:value-of select="tei:forename/."/>
                            </b>
                        </span>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <!-- Nachname -->
                    <xsl:if test="tei:surname">
                        <span class="surname">
                            <xsl:value-of select="tei:surname/."/>
                        </span>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </div>
            </xsl:for-each>
            <!-- Sonstiges zur Person -->
            <xsl:if test="tei:birth">
                <br/>
                <xsl:text>geb. </xsl:text>
                <span class="birth">
                    <xsl:value-of select="tei:birth/."/>
                </span>
            </xsl:if>
            <xsl:if test="tei:death">
                <br/>
                <xsl:text>gest. </xsl:text>
                <span class="death">
                    <xsl:value-of select="tei:death/."/>
                </span>
            </xsl:if>
            <xsl:if test="tei:note">
                <br/>
                <xsl:text>Anm.: </xsl:text>
                <span class="note">
                    <xsl:value-of select="tei:note/."/>
                </span>
            </xsl:if>
        </div>
        
    </xsl:template>
    
    <xsl:template match="tei:place">
        <xsl:call-template name="format-place"/>
    </xsl:template>
    
    <xsl:template name="format-place">
        <div id="{@xml:id}" class="rs-ref">
            <!-- TBD -->
            <xsl:if test="tei:placeName">
                <span class="placeName">
                    <xsl:value-of select="tei:placeName/."/>
                    <xsl:if test="tei:placeName[@ref]">
                        <br/>
                        <a href="{tei:placeName/@ref}" target="_blank" style="color:#160080;">weiterführende Informationen </a>
                    </xsl:if>
                </span>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if test="tei:note">
                <br/>
                <xsl:text>Anm.: </xsl:text>
                <span class="note">
                    <xsl:value-of select="tei:note/."/>
                </span>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:rs">
        <xsl:variable name="id" select="generate-id()"/>
        <xsl:choose>
            
            <xsl:when test="@type='person' or @type='place'">
                <xsl:apply-templates>
                    <xsl:with-param name="id" select="$id"/>
                    <xsl:with-param name="ref" select="@ref"/>
                </xsl:apply-templates>
            </xsl:when>
            
        </xsl:choose>
        
    </xsl:template>
    <xsl:template match="tei:rs[@type='person' or @type='place']/text()
        | tei:w[parent::tei:rs[@type='person' or @type='place']]/text()">
        <xsl:param name="id"/>
        <xsl:param name="ref"/>
        <a href="javascript:void(0)" id="{$id}" class="rs-ref" onclick="showInlineAnnotation(this, '{$ref}');">
            <xsl:choose>
                <xsl:when test="ancestor::tei:w"><xsl:value-of select="normalize-space(.)"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    
    <xsl:template match="tei:ex">
        <xsl:param name="id"/>
        <xsl:param name="ref"/>
        <xsl:choose>
            <xsl:when test="ancestor::tei:rs and not(ancestor::tei:add)">
                <a href="javascript:void(0)" id="{$id}" class="rs-ref ex" onclick="showInlineAnnotation(this, '{$ref}');">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <span class="ex">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:dateline">
        <xsl:choose>
            <xsl:when test="@rendition='#right'">
                <p class="right-align">
                    <xsl:apply-templates/>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>

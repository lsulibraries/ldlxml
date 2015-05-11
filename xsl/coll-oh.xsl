<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns="http://www.loc.gov/mods/v3">
   
    <!-- imports -->
    <xsl:import href="_core.xsl"/>
<!-- Things that appear to work -->
    <xsl:template name="title">
        <xsl:element name="titleInfo">
            <xsl:element name="title">
                <xsl:value-of select="series"/>
            </xsl:element>
            <xsl:element name="subTitle">
                <xsl:value-of select="title"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="originInfo">
        <xsl:element name="originInfo">
            <xsl:call-template name="date">
                <xsl:with-param name="raw" select="date-of-interview"/>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>

    <xsl:template name="filename">
        <xsl:analyze-string select="cite-as" regex="[a-zA-Z,\.\s]+\s([0-9]+\.[0-9]+)">
            <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring/>
        </xsl:analyze-string>
<!--        <xsl:result-document method="xml" href="{identifier}.xml"/>-->
    </xsl:template>
    
    <!-- Everything beyond here is not working properly -->
    <xsl:template name="identifier">
        <!-- is showing up, but empty -->
        <xsl:element name="identifier">
        <xsl:analyze-string select="cite-as" regex="[a-zA-Z,\.\s]+\s([0-9]+\.[0-9]+)">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring/>
        </xsl:analyze-string>
        </xsl:element>
        <xsl:element name="shelfLocator">
            <xsl:value-of>L:</xsl:value-of>
            <xsl:value-of select="regex-group(1)"></xsl:value-of>
        </xsl:element>
    </xsl:template>
   
    <xsl:template name="interviewer">
        <xsl:param name="rawNames" select="interviewer"/>
        <xsl:variable name="rawName" select="tokenize($rawNames,'; ')"/>
        <xsl:variable name="typicalnameregex" select="'([a-zA-Z\s,]+),\s([0-9?-]+)'"/>

        <xsl:element name="name">
            <xsl:choose>
                <xsl:when test="matches($rawName,$typicalnameregex)">
                    <xsl:analyze-string select="$rawName" regex="{$typicalnameregex}">
                        <xsl:matching-substring>
                            <xsl:element name="namePart">
                                <xsl:value-of select="regex-group(1)"/>
                            </xsl:element>
                            <xsl:element name="namePart">
                                <xsl:attribute name="type">date</xsl:attribute>
                                <xsl:value-of select="regex-group(2)"/>
                            </xsl:element>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="namePart">
                        <xsl:value-of select="rawName"/>
                    </xsl:element>
                </xsl:otherwise>
                </xsl:choose>
            <xsl:element name="role">
                <xsl:element name="roleTerm">
                    <xsl:attribute name="type">code</xsl:attribute>
                    <xsl:value-of>ivr</xsl:value-of>
                </xsl:element>
                <xsl:element name="roleTerm">
                    <xsl:attribute name="type">text</xsl:attribute>
                    <xsl:value-of>Interviewer</xsl:value-of>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="interviewee">
        <xsl:param name="rawNames" select="interviewee"/>
        <xsl:variable name="rawName" select="tokenize($rawNames,'; ')"/>
        <xsl:variable name="typicalnameregex" select="'([a-zA-Z\s,]+),\s([0-9?-]+)'"/>
        
        <xsl:element name="name">
            <xsl:choose>
                <xsl:when test="matches($rawName,$typicalnameregex)">
                    <xsl:analyze-string select="$rawName" regex="{$typicalnameregex}">
                        <xsl:matching-substring>
                            <xsl:element name="namePart">
                                <xsl:value-of select="regex-group(1)"/>
                            </xsl:element>
                            <xsl:element name="namePart">
                                <xsl:attribute name="type">date</xsl:attribute>
                                <xsl:value-of select="regex-group(2)"/>
                            </xsl:element>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="namePart">
                        <xsl:value-of select="$rawName"/>
                    </xsl:element>
                </xsl:otherwise>
                <!-- Is there a way, after this has been done, to apply "usage=primary" to just the first one? -->
            </xsl:choose>
            <xsl:element name="role">
                <xsl:element name="roleTerm">
                    <xsl:attribute name="type">code</xsl:attribute>
                    <xsl:value-of>ive</xsl:value-of>
                </xsl:element>
                <xsl:element name="roleTerm">
                    <xsl:attribute name="type">text</xsl:attribute>
                    <xsl:value-of>Interviewee</xsl:value-of>
                </xsl:element>
            </xsl:element>
            <xsl:element name="description">
                <xsl:value-of select="biographical-note"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="physicalDescription">
        <xsl:element name="physicalDescription">
            <xsl:for-each select="tokenize(.,'; ')"/>
            <xsl:variable name="PhysDesc" select="'([0-9a-zA-Z\s,]+)\s?'"/>
            <xsl:choose>
                <xsl:when test="matches(., ';')">
                    <xsl:analyze-string select="." regex="{$PhysDesc}">
                        <xsl:matching-substring>
                            <form>
                                <xsl:value-of select="regex-group(1)"/>
                            </form>
                            <extent>
                                <xsl:value-of select="regex-group(2)"/>
                            </extent>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <xsl:otherwise>
                    <note>
                        <xsl:attribute name="type">content</xsl:attribute>
                        <xsl:value-of select="."/>
                    </note>
                </xsl:otherwise>
            </xsl:choose>
            <!-- move below to core? Why did it break when I just added another section that was nearly identical!?! -->
            <xsl:choose>
                <xsl:when test="empty(ancestor-or-self::record/photographer)"> </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="form">Photograph/Pictorial Works</xsl:element>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="empty(ancestor-or-self::record/interviewee)"></xsl:when>
                <xsl:otherwise>
                    <xsl:element name="form">Oral History</xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
        <xsl:element name="typeOfResource">sound recording</xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
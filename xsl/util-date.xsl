<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lsu="http://lsu.edu"
    xmlns="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:template match="date">
        <xsl:variable name="raw" select="."/>
        <xsl:message>
            Processing date:
            <xsl:value-of select="."/>
        </xsl:message>

        <!--instead of fn call-->
        
          <xsl:call-template name="lsu:dateCreated">
              <xsl:with-param name="rawDate" select="$raw"/>
          </xsl:call-template>
        
        
    </xsl:template>



    <xsl:template name="lsu:dateCreated">
        <xsl:param name="rawDate" as="xs:string"/>
        <!--   lower case test value     -->
        <xsl:variable name="lsu:date-lower" select="lower-case(.)"/>


        <!--        error block-->
        <!--   These values are invalid and should throw an error     -->
        <xsl:variable name="lsu:nd-strict"       select="'^n\.d\.$'"/>
        <xsl:variable name="lsu:unk-strict"      select="'^unknown$'"/>
        <xsl:variable name="lsu:unk-date-strict" select="'^unknown date$'"/>
        <xsl:variable name="lsu:unk-date-leading-zero"   select="'^0.{1,5}$'"/>

        
        <xsl:choose>
            <xsl:when test="matches($lsu:date-lower, $lsu:nd-strict) or 
                            matches($lsu:date-lower, $lsu:unk-strict) or 
                            matches($lsu:date-lower, $lsu:unk-date-strict) or
                            matches($lsu:date-lower, $lsu:unk-date-leading-zero)"
                >
                <xsl:value-of select="error(QName('http://lib.lsu.edu', 'Source metadata missing date.'))"/>
            </xsl:when>
        </xsl:choose>
        <!--  end error block-->

        <!--   dates that also include extraneous text-->
        <xsl:variable name="lsu:regex-letters" select="'[a-z]+'"></xsl:variable>
        <xsl:variable name="nd" select="'n\.d\.'"/>
        <xsl:variable name="lsu:unk" select="'unknown'"></xsl:variable>
        <xsl:variable name="lsu:date-incl-nd" select="'([0-9]+)-([0-9]+),\s?(n.d.)'"/>
        <xsl:variable name="lsu:date-incl-unk" select="'([0-9]+)-([0-9]+),\s?unknown'"/>
        <xsl:variable name="lsu:acceptable-dates" select="'[0-9/,\-?]+'"/>

        <xsl:choose>
            <xsl:when test="matches($lsu:date-lower, $lsu:regex-letters)">
                <xsl:choose>
                    <xsl:when test="matches($lsu:date-lower, $lsu:date-incl-nd)">
                        <xsl:analyze-string select="$lsu:date-lower" regex="{$lsu:date-incl-nd}">
                            <xsl:matching-substring>
                                <xsl:element name="dateCreated">
                                    <!--<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
                                    <xsl:attribute name="keyDate">yes</xsl:attribute>-->
                                    <xsl:value-of select="regex-group(1)"/>
                                    <xsl:value-of>?-</xsl:value-of>
                                    <xsl:value-of select="regex-group(2)"/>
                                    <xsl:value-of>?</xsl:value-of>
                                </xsl:element>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:when>
                    <xsl:when test="matches($lsu:date-lower, $lsu:date-incl-unk)">
                        <xsl:analyze-string select="$lsu:date-lower" regex="{$lsu:date-incl-unk}">
                            <xsl:matching-substring>
                                <xsl:element name="dateCreated">
                                    <!--<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
                                    <xsl:attribute name="keyDate">yes</xsl:attribute>-->
                                    <xsl:value-of select="regex-group(1)"/>
                                    <xsl:value-of>?-</xsl:value-of>
                                    <xsl:value-of select="regex-group(2)"/>
                                    <xsl:value-of>?</xsl:value-of>
                                </xsl:element>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:when>
                    <xsl:otherwise>
                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="matches($lsu:date-lower, $lsu:acceptable-dates)">
                        <xsl:element name="dateCreated">
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="error(QName('http://lib.lsu.edu', 'Source dates do not conform to metadata requirements.'))"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
            <!--  end dates that also include extraneous text-->
    </xsl:template>
</xsl:stylesheet>
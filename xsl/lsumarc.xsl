<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.loc.gov/mods/v3">
    <xsl:import href="marc21slimMods3-5.xsl"/>
    <xsl:import href="util-date.xsl"/>
    <xsl:import href="util-name.xsl"/>
    <xsl:output indent="yes"/>
    
    <!--  <xsl:template match="/marc:record">
        <xsl:apply-templates/>
    </xsl:template>-->
    
    <xsl:template match="/">
        
        <xsl:choose>
            <xsl:when test="//marc:collection">
                <modsCollection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
                    <xsl:for-each select="//marc:collection/marc:record">
                        <xsl:variable name="filename-tmp">
                            <xsl:call-template name="filename"/> <!--   Must be overridden by collection-specific template.   -->
                        </xsl:variable>
                        
                        <xsl:result-document method="xml" href="{$filename-tmp}.xml">

                            <mods xmlns="http://www.loc.gov/mods/v3"
                                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                xmlns:mods="http://www.loc.gov/mods/v3"
                                xmlns:xlink="http://www.w3.org/1999/xlink"
                                xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">

                                <xsl:call-template name="marcRecord"/>
                                <xsl:call-template name="DeweycallNumber"/>

                            </mods>
                        </xsl:result-document>
                    </xsl:for-each>
                </modsCollection>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="/marc:record">
                    <xsl:variable name="filename-tmp">
                        <xsl:call-template name="filename"/> <!--   Must be overridden by collection-specific template.   -->
                    </xsl:variable>
                    
                    <xsl:result-document method="xml" href="{$filename-tmp}.xml">
                <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.5"
                    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
                    <xsl:for-each select="/marc:record">
                        <xsl:call-template name="marcRecord"/>
                    </xsl:for-each>
                </mods>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="filename">
        <xsl:value-of select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
    </xsl:template>
    
   <!-- does this work? Do we need it, or is this info covered by what the main template does to the 001 field? 
       <xsl:template name="proquestid">
        <xsl:element name="identifier">
            <xsl:attribute name="type">proquestID</xsl:attribute>
        <xsl:value-of select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
        </xsl:element>
    </xsl:template> -->
    
    <xsl:template name="DeweycallNumber">
        <xsl:element name="identifier">
            <xsl:attribute name="type">dewey</xsl:attribute>
            <xsl:value-of
                select="marc:datafield[@tag='999']/marc:subfield[@code='a'][../marc:subfield[@code='w']/text()='DEWEY']"/>
        </xsl:element>
</xsl:template>

</xsl:stylesheet>


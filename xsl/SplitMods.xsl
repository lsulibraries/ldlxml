<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xpath-default-namespace="http://www.loc.gov/mods/v3">
    
<!--added by Rachel-->
    <xsl:output omit-xml-declaration="yes" indent="yes"/>

    <xsl:template match="mods">
        

        <xsl:result-document method="xml" href="{identifier}_{titleInfo/title}.xml">
            <modsCollection xmlns="http://www.loc.gov/mods/v3"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink"
                xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
               

                <!--<xsl:template match="mods">
                    xmlns="http://www.loc.gov/mods/v3"
                </xsl:template>-->
                <mods xmlns="http://www.loc.gov/mods/v3">
                    <xsl:copy-of select="node()"/>                
                </mods>
           </modsCollection>
        </xsl:result-document>

    </xsl:template>
    <!--Rachel's attempt to write a new template
    <xlmns:m="http://www.loc.gov/mods/v3">
    <xsl:template match="split">
        <xsl:copy-of select="node()"></xsl:copy-of>
    </xsl:template>
    </xlmns:m>
    -->
    <!--   written out to try simpler approach
     
                <xsl:apply-templates select="node()"/>
                <xsl:apply-templates />
                
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>
-->

    <!-- Just change the match="/*" to match="*" ; if you want to add namespace in all elements 
    <xsl:template match="*">
        <xsl:element name="{local-name()}" namespace="http://www.loc.gov/mods/v3">
            <xsl:apply-templates select="node()|@*"/>
        </xsl:element>
    </xsl:template>
    -->
    <!--Rachel's attempt to write a new template
    <M:mods xmlns:m=''/>
   -->
</xsl:stylesheet>

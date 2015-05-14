<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0" xmlns="http://www.loc.gov/mods/v3">

    <!--  imports   -->
    <xsl:import href="defaults.xsl"/>
<!--    <xsl:import href="util.xsl"/>-->
    <xsl:import href="util-date.xsl"/>
    <xsl:import href="util-name.xsl"/>
    <xsl:output indent="yes"/>


    <xsl:template match="/records">
        <xsl:apply-templates/>
    </xsl:template>

    
    <xsl:template match="record">

        <xsl:variable name="filename-tmp">
            <xsl:call-template name="filename"/> <!--   Must be overridden by collection-specific template.   -->
        </xsl:variable>

        <xsl:result-document method="xml" href="{$filename-tmp}.xml">

            <modsCollection xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink"
                xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">

                <xsl:element name="mods" namespace="http://www.loc.gov/mods/v3">

                    <!-- Call templates for each section to be included in the MODS output. -->
                    <xsl:call-template name="title"/>
                    <xsl:call-template name="name"/>
                    <!-- <xsl:apply-templates select="photographer"/>-->
                    <!-- @TODO - Fix photographer.                   -->
                    <xsl:call-template name="originInfo"/>
                    <xsl:call-template name="physicalDescription"/>
                    <xsl:call-template name="subjects"/>
                    <xsl:call-template name="recordInfo"/>
                    <xsl:call-template name="access"/>
                    <xsl:call-template name="location"/>
                    <xsl:call-template name="series"/>
                </xsl:element>
            </modsCollection>
        </xsl:result-document>
    </xsl:template>

    <!--    not implemented by default.  -->
    <xsl:template match="cite-as"/>
    <xsl:template match="collection-url"/>
    <xsl:template match="contact-and-ordering-information"/>
    <xsl:template match="date-created"/>
    <xsl:template match="date-modified"/> 
    <xsl:template match="digital-collection"/>
    <xsl:template name="filename"/>
    <xsl:template match="filename"/>
    <xsl:template match="item-number"/>
    <xsl:template match="item-url"/>
    <xsl:template name="name"/>
    <xsl:template name="originInfo"/>
    <xsl:template match="physical-description"/>
    <xsl:template name="physicalDescription"/>
    <xsl:template match="repository"/>
    <xsl:template match="repository-collection-guide"/>
    <xsl:template name="series"/>
    <xsl:template name="title"/>
</xsl:stylesheet>
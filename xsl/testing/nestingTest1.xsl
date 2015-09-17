<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0" xmlns="http://www.loc.gov/mods/v3">

    <!-- imports -->
    <xsl:import href="MARC21slim_MODS3-5_XSLT2-0.xsl"/>
    <xsl:import href="util-date.xsl"/>
    <xsl:import href="util-name.xsl"/>
    <xsl:output indent="yes"/>

    <xsl:template match="/">

        <xsl:choose>
            <xsl:when test="//marc:collection">
                <modsCollection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd"
                    > <xsl:for-each select="//marc:collection/marc:record">
                        <xsl:variable name="filename-tmp">
                            <xsl:call-template name="filename"/>
                            <!--   Must be overridden by collection-specific template. -->
                        </xsl:variable> <xsl:result-document method="xml" href="{$filename-tmp}.xml">
                            <mods xmlns="http://www.loc.gov/mods/v3"
                                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                xmlns:mods="http://www.loc.gov/mods/v3"
                                xmlns:xlink="http://www.w3.org/1999/xlink"
                                xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd"
                                > <xsl:apply-templates select="."/> </mods>
                        </xsl:result-document>
                    </xsl:for-each>
                </modsCollection>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="/marc:record">
                    <xsl:variable name="filename-tmp">
                        <xsl:call-template name="filename"/>
                        <!--   Must be overridden by collection-specific template.   -->
                    </xsl:variable>

                    <xsl:result-document method="xml" href="{$filename-tmp}.xml">
                        <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.5"
                            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
                            <xsl:for-each select="/marc:record">
                                <xsl:apply-templates select="marc:record"/>
                            </xsl:for-each>
                        </mods>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- empty templates-->
    <xsl:template name="lsuLocaltemplates">
        <xsl:call-template name="DeweycallNumber"/>
        <xsl:call-template name="ProQuestID"/>
        <xsl:call-template name="location"/>
        <xsl:call-template name="access"/>
        <xsl:call-template name="physicalDescription"/>
    </xsl:template>

    <xsl:template name="filename"/>
    <xsl:template name="ProQuestID"/>
    <xsl:template name="location"/>
    <xsl:template name="physicalDescription">
        <xsl:param name="typeOf008"/>
        <xsl:param name="controlField008"/>
        <xsl:param name="leader6"/>
    </xsl:template>
    <xsl:template name="DeweycallNumber"/>

    <!-- access information template -->
    <xsl:template name="access">
        <xsl:element name="note">
            <xsl:attribute name="type">ownership</xsl:attribute> LSU Libraries, Baton Rouge, La.,
            http://lib.lsu.edu/ </xsl:element>

        <xsl:element name="accessCondition">
            <xsl:attribute name="type">restriction on access</xsl:attribute> LSU claims physical
            rights of these materials. As a general statement, LSU makes no ownership claim to the
            intellectual property contained within unless the works incorporate or reference other
            items owned by LSU. The materials in these digital collections are made available for
            use in research, teaching, and private study, pursuant to U.S. Copyright law. The user
            must assume full responsibility for any use of the materials, including but not limited
            to, infringement of copyright and publication rights of reproduced materials. Any
            materials used for academic research or otherwise should be fully credited with the
            source. </xsl:element>

        <xsl:element name="accessCondition">
            <xsl:attribute name="type">use and reproduction</xsl:attribute> To provide comments
            about this digital project or inquire about ordering copies of these images, email
            lsudiglib@lsu.edu. Mention the "Identifier" in your request. Providing reproductions
            does not constitute permission to publish or reproduce images in print or electronic
            form. </xsl:element>
    </xsl:template>

</xsl:stylesheet>

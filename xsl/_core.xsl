<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns="http://www.loc.gov/mods/v3">
    <xsl:import href="util-date.xsl"/>

    <xsl:output indent="yes"/>
    
    <xsl:template match="/records">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="record">
        <xsl:result-document method="xml" href="{item-number}_{title}.xml">
            <modsCollection xmlns="http://www.loc.gov/mods/v3"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink"
                xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
                
                <xsl:element name="mods" namespace="http://www.loc.gov/mods/v3">
                    <xsl:apply-templates select="title"/>
                    <xsl:apply-templates select="photographer"/>
                    <xsl:call-template name="src"/>
                    <!--<xsl:call-template name="virtual"/>-->
                    <xsl:apply-templates select="physical-description"/>
                    <xsl:apply-templates select="subjects"/>
                    <xsl:call-template name="recordInfo"/>
                    <xsl:call-template name="access"/>
                    <xsl:call-template name="location"/>
                </xsl:element>
            </modsCollection>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="title">
        <xsl:element name="titleInfo">
            <xsl:element name="title">
                <xsl:value-of select="replace(., '(\s\s+)', 'SplitMods.xsl ')"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template name="virtual">
        <xsl:element name="relatedItem">
            <!-- see the following for an example http://library.princeton.edu/departments/tsd/metadoc/mods/relateditem.html           -->
            <xsl:attribute name="type">host</xsl:attribute>
            <xsl:element name="typeOfResource">
                <xsl:attribute name="collection">yes</xsl:attribute>still image</xsl:element>
            <xsl:element name="titleInfo">
                <xsl:attribute name="type">uniform</xsl:attribute>
                <xsl:attribute name="authority">?????</xsl:attribute>
                <xsl:element name="title">
                    <xsl:value-of select="digital-collection"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template name="src">
        <xsl:element name="originInfo">
            <xsl:apply-templates select="date"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="physical-description">
        <!--this section may need to recoded based on the structure of each collections' physical description field-->
        <xsl:element name="physicalDescription">
            <xsl:variable name="PhysDesc" select="'([0-9a-zA-Z\s,]+);\s?([0-9\sa-zA-Z.&quot;]+)'"/>
            <xsl:choose>
                <xsl:when test="matches(., ';')">
                    <xsl:analyze-string select="." regex="{$PhysDesc}">
                        <xsl:matching-substring>
                            <note>
                                <xsl:attribute name="type">content</xsl:attribute>
                                <xsl:value-of select="regex-group(1)"/>
                            </note>
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
            <xsl:choose>
                <xsl:when test="empty(ancestor-or-self::record/photographer)"> </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="form">Photograph/Pictorial Works</xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>

        <xsl:choose>
            <xsl:when test="empty(ancestor-or-self::record/photographer)"> </xsl:when>
            <xsl:otherwise>
                <xsl:element name="typeOfResource">still image</xsl:element>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="recordInfo">
        <xsl:element name="identifier">
            <xsl:value-of select="item-number"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="photographer">
        <xsl:element name="name">
            <xsl:variable name="regex" select="'([a-zA-Z\s,]+),\s([0-9?-]+)'"/>

            <xsl:choose>
                <xsl:when test="matches(., $regex)">
                    <xsl:attribute name="type">personal</xsl:attribute>
                    <xsl:attribute name="usage">primary</xsl:attribute>
                    <xsl:variable name="photog" select="."/>

                    <xsl:analyze-string select="$photog" regex="{$regex}">

                        <xsl:matching-substring>
                            <namePart>
                                <xsl:value-of select="regex-group(1)"/>
                            </namePart>
                            <namePart type="date">
                                <xsl:value-of select="regex-group(2)"/>
                            </namePart>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                    <xsl:element name="role">
                        <xsl:element name="roleTerm">
                            <xsl:attribute name="type">code</xsl:attribute>
                            <xsl:attribute name="authority"
                            >marcrelator</xsl:attribute>pht</xsl:element>
                        <xsl:element name="roleTerm">
                            <xsl:attribute name="type">text</xsl:attribute>
                            <xsl:attribute name="authority">marcrelator</xsl:attribute>Photographer
                        </xsl:element>
                    </xsl:element>

                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="compare(upper-case(.), 'Unknown')">
                        <xsl:element name="namePart">
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <xsl:template match="subjects">
        <xsl:for-each select="tokenize(.,';')">
            <xsl:element name="subject">
                <xsl:element name="topic">
                    <xsl:attribute name="authority">LoC</xsl:attribute>
                    <xsl:value-of select="replace(., '^\s+|\s+$', '')"/>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
       
    </xsl:template>

    <xsl:template name="access">
        <xsl:element name="note">
            <xsl:attribute name="type">ownership</xsl:attribute>
            <xsl:value-of select="repository"/>
        </xsl:element>
        <xsl:element name="accessCondition">
            <xsl:attribute name="type">restriction on access</xsl:attribute>
            <xsl:call-template name="restrictions"/>
        </xsl:element>
        <xsl:element name="accessCondition">
            <xsl:attribute name="type">use and reproduction</xsl:attribute>
            <xsl:value-of select="contact-and-ordering-information"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="digital-collection"> </xsl:template>

    <xsl:template name="location">
        <xsl:element name="location">
            <xsl:element name="physicalLocation">LUU</xsl:element>
            <xsl:element name="physicalLocation">LSU Libraries</xsl:element>
            <xsl:element name="url">http://www.lib.lsu.edu</xsl:element>
            <xsl:element name="holdingSimple">
                <!--will need to be edited for each collection; can add an if statement based on identifier that changes the shelfLocator based on content-->
                <xsl:element name="copyInformation">
                    <xsl:element name="subLocation">Hill Memorial Library, Special
                        Collections</xsl:element>
                    <xsl:element name="shelfLocator">M:22</xsl:element>
                    <!-- Once we have EAD information, we could add it to a holdingExternal element here -->
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="repository"> </xsl:template>

    <xsl:template match="repository-collection-guide"> </xsl:template>

    <xsl:template match="cite-as"> </xsl:template>

    <xsl:template name="restrictions">
        <xsl:value-of select="restrictions"/>
    </xsl:template>

    <xsl:template match="contoct-and-ordering-information"> </xsl:template>

    <xsl:template match="item-number"> </xsl:template>

    <xsl:template match="item-url"> </xsl:template>

    <xsl:template match="collection-url"> </xsl:template>

    <xsl:template match="date-created">
        <xsl:element name="dateCreated">
            <xsl:attribute name="encoding">w3cdtf</xsl:attribute>
            <xsl:attribute name="keyDate">yes</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="date-modified"> </xsl:template>

    
</xsl:stylesheet>
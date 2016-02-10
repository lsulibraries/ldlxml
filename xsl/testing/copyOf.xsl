<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.loc.gov/mods/v3">
    
    <!-- imports -->
    <xsl:import href="MARC21slim_MODS3-5_XSLT2-0.xsl"/>
    <xsl:import href="util-date.xsl"/>
    <xsl:import href="util-name.xsl"/>
    <xsl:output indent="yes"/> 
          <!-- IdentityTransform -->
          <xsl:template match="@*">
                    <xsl:copy copy-namespaces="yes">
                        <mods xmlns="http://www.loc.gov/mods/v3"
                            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                            xmlns:mods="http://www.loc.gov/mods/v3"
                            xmlns:xlink="http://www.w3.org/1999/xlink"
                            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd"
                            >
                            <xsl:apply-templates select="." />
                        </mods>
                    </xsl:copy>
              
          </xsl:template>
    <xsl:template name="filename">
        <xsl:value-of select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
    </xsl:template>       
  
</xsl:stylesheet>
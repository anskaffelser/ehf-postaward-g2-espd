<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ct="urn:fdc:difi.no:2017:vefa:espd:CriteriaTaxonomy-1"
                xmlns="urn:fdc:difi.no:2017:vefa:structure:CodeList-1"
                exclude-result-prefixes="ct">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/ct:CriteriaTaxonomy">
        <CodeList>
            <Title>Optional criterias</Title>
            <Identifier>CriteriaOptional</Identifier>
            <Version><xsl:value-of select="ct:Version[1]/text()"/></Version>
            <Agency>Agency of Public Management and eGovernment</Agency>
            
            <xsl:for-each select="ct:Criterion[@required='false']">
                <Code>
                    <Id><xsl:value-of select="@id"/></Id>
                    <Name><xsl:value-of select="ct:Name/ct:Source/text()"/></Name>
                </Code>
            </xsl:for-each>

        </CodeList>
    </xsl:template>

</xsl:stylesheet>

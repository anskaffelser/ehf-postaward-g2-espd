<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"
                xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"
                xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"
                xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
                xmlns:espd-req="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"
                xmlns:ct="urn:fdc:difi.no:2017:vefa:espd:CriteriaTaxonomy-1"
                exclude-result-prefixes="ct">

    <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes" />
    <xsl:strip-space elements="*"/>

    <xsl:template match="/ct:CriteriaTaxonomy">
        <html>
            <head>

                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>

                <title>Criteria Taxonomy</title>

                <!-- Latest compiled and minified CSS -->
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>
            </head>
            <body>
                <h1>Critieria Taxonomy</h1>

                <xsl:apply-templates select="ct:Criterion"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="ct:Criterion">
        <h3><xsl:value-of select="ct:Type/text()" /></h3>

        <table class="table table-condensed table-striped">
            <thead>
                <tr>
                    <th style="width: 60pt;">UUID</th>
                    <th>Description</th>
                    <th style="width: 200pt;">Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><xsl:value-of select="substring(@id, 1, 4)" /></td>
                    <xsl:if test="string-length(ct:Description/ct:Source/text()) &gt; 70"><td><xsl:value-of select="substring(ct:Description/ct:Source/text(), 1, 70)"/>[..]</td></xsl:if>
                    <xsl:if test="string-length(ct:Description/ct:Source/text()) &lt;= 70"><td><xsl:value-of select="ct:Description/ct:Source/text()"/></td></xsl:if>
                    <td></td>
                </tr>
                <xsl:apply-templates select="ct:RequirementGroupId"/>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template match="ct:RequirementGroup">
        <tr>
            <td><xsl:value-of select="substring(@id, 1, 4)" /></td>
            <td></td>
            <xsl:if test="ct:ProsessingInstruction"><td><xsl:value-of select="ct:ProsessingInstruction/text()"/></td></xsl:if>
            <xsl:if test="not(ct:ProsessingInstruction)"><td></td></xsl:if>

        </tr>
        <xsl:apply-templates select="ct:RequirementId"/>
        <xsl:apply-templates select="ct:RequirementGroupId"/>
    </xsl:template>

    <xsl:template match="ct:Requirement">
        <tr>
            <td><xsl:value-of select="substring(@id, 1, 4)" /></td>
            <td><xsl:value-of select="ct:Description/ct:Source/text()"/></td>
            <td></td>
        </tr>
    </xsl:template>

    <xsl:template match="ct:RequirementGroupId">
        <xsl:variable name="id" select="text()"/>
        <xsl:apply-templates select="//ct:RequirementGroup[@id = $id]"/>
    </xsl:template>

    <xsl:template match="ct:RequirementId">
        <xsl:variable name="id" select="text()"/>
        <xsl:apply-templates select="//ct:Requirement[@id = $id]"/>
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:ct="urn:fdc:difi.no:2017:vefa:espd:CriteriaTaxonomy-1"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://purl.oclc.org/dsdl/schematron"
                xmlns:u="utils"
                exclude-result-prefixes="xsl xs ct u">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:param name="pattern_only" select="'false'"/>
    <xsl:param name="prefix" select="'EHF-ESPD-CTR'"/>

    <xsl:function name="u:pid" as="xs:string">
        <xsl:param name="id"/>
        <xsl:value-of select="if (string-length(string($id)) &lt; 2) then concat('0', string($id)) else string($id)"/>
    </xsl:function>

    <xsl:function name="u:escape" as="xs:string">
        <xsl:param name="text"/>
        <xsl:value-of select="replace(normalize-space($text), '''', '''''')"/>
    </xsl:function>

    <xsl:function name="u:getpi" as="xs:string">
        <xsl:param name="pi"/>

        <xsl:choose>
            <xsl:when test="$pi = 'GROUP_FULFILLED.ON_TRUE'">
                <xsl:text>[normalize-space(../ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator) = 'true']</xsl:text>
            </xsl:when>
            <xsl:when test="$pi = 'GROUP_FULFILLED.ON_FALSE'">
                <xsl:text>[normalize-space(../ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator) = 'false']</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="u:getpineg" as="xs:string">
        <xsl:param name="pi"/>

        <xsl:choose>
            <xsl:when test="$pi = 'GROUP_FULFILLED.ON_TRUE'">
                <xsl:text>[normalize-space(../ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator) = 'false']</xsl:text>
            </xsl:when>
            <xsl:when test="$pi = 'GROUP_FULFILLED.ON_FALSE'">
                <xsl:text>[normalize-space(../ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator) = 'true']</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:variable name="root" select="/ct:CriteriaTaxonomy"/>

    <xsl:template match="/ct:CriteriaTaxonomy">
        <xsl:choose>
            <xsl:when test="$pattern_only = 'true'">
                <xsl:call-template name="pattern"/>
            </xsl:when>
            <xsl:otherwise>
                <schema schemaVersion="iso" queryBinding="xslt2">

                    <title>Response validation rules for EHF ESPD</title>

                    <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
                    <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
                    <ns prefix="ccv-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"/>
                    <ns prefix="cev-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"/>
                    <ns prefix="cev" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/>
                    <ns prefix="espd" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"/>
                    <ns prefix="espd-req" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"/>
                    <ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
                    <ns prefix="espd-cbc" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"/>
                    <ns prefix="ccv" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"/>
                    <ns prefix="espd-cac" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1"/>>

                    <xsl:call-template name="pattern"/>
                </schema>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="pattern">
        <pattern>
            <xsl:for-each select="ct:Criterion">
                <let name="{concat('answered-', @id)}" value="{concat('ccv:Criterion[normalize-space(cbc:ID/text()) = ''', @id , ''']//ccv:Response[1]')}"/>
            </xsl:for-each>

            <xsl:variable name="criterions">
                <xsl:apply-templates select="ct:Criterion"/>
            </xsl:variable>

            <!--  <xsl:copy-of select="$criterions"/> -->

            <xsl:for-each select="$criterions/*:LocalCriterion">
                <xsl:apply-templates select="." mode="produce">
                    <xsl:with-param name="id" select="concat($prefix, '-', u:pid(position()))"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </pattern>
    </xsl:template>

    <xsl:template match="ct:Criterion">
        <xsl:variable name="location" select="concat('ccv:Criterion[normalize-space(cbc:ID/text()) = ''', @id , ''']')"/>

        <LocalCriterion>

            <rule context="{concat($location, '[not($answered-', @id, ')]')}">
                <xsl:comment> Not answered! </xsl:comment>
                <assert id="{concat($prefix, '-C', u:pid(position()))}"
                        test="{concat('not($answered-', @id, ')')}"
                        flag="fatal">Criterion '<xsl:value-of select="@id"/>' is not answered.</assert>
            </rule>

            <rule context="{concat($location, '[not($answered-', @id, ')]/ccv:Requirement')}">
                <!-- No action -->
            </rule>

            <xsl:for-each select="ct:RequirementId">
                <xsl:apply-templates select=".">
                    <xsl:with-param name="path" select="$location"/>
                    <xsl:with-param name="position" select="position()"/>
                    <xsl:with-param name="optional" select="@optional = 'true'"/>
                    <xsl:with-param name="expected" select="true()"/>
                </xsl:apply-templates>
            </xsl:for-each>

            <xsl:for-each select="ct:RequirementGroupId">
                <xsl:apply-templates select=".">
                    <xsl:with-param name="path" select="$location"/>
                    <xsl:with-param name="optional" select="@optionalFields = 'true'"/>
                    <xsl:with-param name="expected" select="true()"/>
                </xsl:apply-templates>
            </xsl:for-each>

        </LocalCriterion>
    </xsl:template>

    <xsl:template match="ct:RequirementGroupId">
        <xsl:param name="path"/>
        <xsl:param name="optional"/>
        <xsl:param name="expected"/>

        <xsl:variable name="id" select="normalize-space(text())"/>
        <xsl:variable name="location" select="concat('ccv:RequirementGroup[normalize-space(cbc:ID/text()) = ''', $id , ''']')"/>

        <xsl:apply-templates select="//ct:RequirementGroup[@id = $id]">
            <xsl:with-param name="path" select="concat($path, '/', $location)"/>
            <xsl:with-param name="optional" select="$optional or @optional = 'true'"/>
            <xsl:with-param name="expected" select="$expected"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ct:RequirementGroup">
        <xsl:param name="path"/>
        <xsl:param name="optional"/>
        <xsl:param name="expected"/>

        <xsl:variable name="pi" select="ct:ProsessingInstruction[1]"/>
        <xsl:comment select="$pi"/>

        <xsl:if test="$pi">
            <xsl:for-each select="ct:RequirementId">
                <xsl:apply-templates select=".">
                    <xsl:with-param name="path" select="concat($path, u:getpi($pi))"/>
                    <xsl:with-param name="position" select="position()"/>
                    <xsl:with-param name="optional" select="$optional or @optional = 'true'"/>
                    <xsl:with-param name="expected" select="$expected"/>
                </xsl:apply-templates>
            </xsl:for-each>

            <xsl:for-each select="ct:RequirementGroupId">
                <xsl:apply-templates select=".">
                    <xsl:with-param name="path" select="concat($path, u:getpi($pi))"/>
                    <xsl:with-param name="position" select="position()"/>
                    <xsl:with-param name="optional" select="$optional or @optionalFields = 'true'"/>
                    <xsl:with-param name="expected" select="$expected"/>
                </xsl:apply-templates>
            </xsl:for-each>

            <xsl:if test="$expected">
                <xsl:for-each select="ct:RequirementId">
                    <xsl:apply-templates select=".">
                        <xsl:with-param name="path" select="concat($path, u:getpineg($pi))"/>
                        <xsl:with-param name="position" select="position()"/>
                        <xsl:with-param name="optional" select="$optional or @optional = 'true'"/>
                        <xsl:with-param name="expected" select="false()"/>
                    </xsl:apply-templates>
                </xsl:for-each>

                <xsl:for-each select="ct:RequirementGroupId">
                    <xsl:apply-templates select=".">
                        <xsl:with-param name="path" select="concat($path, u:getpineg($pi))"/>
                        <xsl:with-param name="position" select="position()"/>
                        <xsl:with-param name="optional" select="$optional or @optionalFields = 'true'"/>
                        <xsl:with-param name="expected" select="false()"/>
                    </xsl:apply-templates>
                </xsl:for-each>
            </xsl:if>
        </xsl:if>

        <xsl:if test="not($pi)">
            <xsl:for-each select="ct:RequirementId">
                <xsl:apply-templates select=".">
                    <xsl:with-param name="path" select="$path"/>
                    <xsl:with-param name="position" select="position()"/>
                    <xsl:with-param name="optional" select="$optional or @optional = 'true'"/>
                    <xsl:with-param name="expected" select="$expected"/>
                </xsl:apply-templates>
            </xsl:for-each>

            <xsl:for-each select="ct:RequirementGroupId">
                <xsl:apply-templates select=".">
                    <xsl:with-param name="path" select="$path"/>
                    <xsl:with-param name="position" select="position()"/>
                    <xsl:with-param name="optional" select="$optional or @optionalFields = 'true'"/>
                    <xsl:with-param name="expected" select="$expected"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template match="ct:RequirementId">
        <xsl:param name="path"/>
        <xsl:param name="position"/>
        <xsl:param name="optional"/>
        <xsl:param name="expected"/>

        <xsl:variable name="id" select="normalize-space(text())"/>
        <xsl:variable name="location" select="concat('ccv:Requirement[', $position , ']')"/>

        <xsl:apply-templates select="//ct:Requirement[@id = $id]">
            <xsl:with-param name="path" select="concat($path, '/', $location)"/>
            <xsl:with-param name="optional" select="$optional or @optional = 'true'"/>
            <xsl:with-param name="expected" select="$expected"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ct:Requirement">
        <xsl:param name="path"/>
        <xsl:param name="optional"/>
        <xsl:param name="expected"/>

        <xsl:if test="$expected">
            <rule context="{$path}">
                <assert test="ccv:Response"
                        flag="{if ($optional) then 'warning' else 'fatal'}">Response <xsl:value-of select="if ($optional) then 'MAY' else 'MUST'"/> be provided.</assert>
            </rule>
        </xsl:if>
        <xsl:if test="not($expected)">
            <rule context="{$path}">
                <assert test="not(ccv:Response)"
                        flag="fatal">Response MUST NOT be provided.</assert>
            </rule>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*:LocalCriterion" mode="produce">
        <xsl:param name="id"/>

        <xsl:for-each select="*:rule">
            <xsl:apply-templates select="." mode="produce">
                <xsl:with-param name="id" select="concat($id, u:pid(position()))"/>
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="*:rule" mode="produce">
        <xsl:param name="id"/>

        <rule context="{@context}">
            <xsl:for-each select="*:assert">
                <xsl:apply-templates select="." mode="produce">
                    <xsl:with-param name="id" select="concat($id, u:pid(position()))"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </rule>
    </xsl:template>

    <xsl:template match="*:assert" mode="produce">
        <xsl:param name="id"/>

        <xsl:element name="assert">
            <xsl:attribute name="id" select="$id"/>
            <xsl:attribute name="test" select="@test"/>
            <xsl:attribute name="flag" select="@flag"/>
            <xsl:copy-of select="text()"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
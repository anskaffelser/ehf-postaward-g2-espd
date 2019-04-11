<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils">

    <!-- Response -->

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'AMOUNT']/ccv:Response">
        <assert id="EHF-ESPD-R120"
                test="cbc:Amount"
                flag="fatal">Amount element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'CODE']/ccv:Response">
        <assert id="EHF-ESPD-R121"
                test="ccv-cbc:Code"
                flag="fatal">Code element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'CODE_COUNTRY']/ccv:Response">
        <assert id="EHF-ESPD-R122"
                test="ccv-cbc:Code"
                flag="fatal">Code element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'DATE']/ccv:Response">
        <assert id="EHF-ESPD-R123"
                test="cbc:Date"
                flag="fatal">Date element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'DESCRIPTION']/ccv:Response">
        <assert id="EHF-ESPD-R124"
                test="cbc:Description"
                flag="fatal">Description element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'EVIDENCE_URL']/ccv:Response">
        <assert id="EHF-ESPD-R125"
                test="cev-cac:Evidence"
                flag="fatal">Evidence element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'INDICATOR']/ccv:Response">
        <assert id="EHF-ESPD-R126"
                test="ccv-cbc:Indicator"
                flag="fatal">Indicator element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'PERCENTAGE']/ccv:Response">
        <assert id="EHF-ESPD-R127"
                test="cbc:Percent"
                flag="fatal">Percent element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'PERIOD']/ccv:Response">
        <assert id="EHF-ESPD-R128"
                test="cac:Period"
                flag="fatal">Period element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'QUANTITY_INTEGER']/ccv:Response">
        <assert id="EHF-ESPD-R129"
                test="cbc:Quantity[not(@unitCode)]"
                flag="fatal">Quantity element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'QUANTITY_YEAR']/ccv:Response">
        <assert id="EHF-ESPD-R130"
                test="cbc:Quantity[@unitCode = 'YEAR']"
                flag="fatal">Quantity element MUST be provided as response when specified.</assert>
    </rule>

    <rule context="ccv:Requirement[/espd:ESPDResponse][@responseDataType = 'QUANTITY']/ccv:Response">
        <assert id="EHF-ESPD-R131"
                test="cbc:Quantity[@unitCode and @unitCode != 'YEAR']"
                flag="fatal">Quantity element MUST be provided as response when specified.</assert>
    </rule>
        

    <!-- Additional Document Reference -->

    <rule context="cac:AdditionalDocumentReference[/espd:ESPDResponse][normalize-space(cbc:DocumentTypeCode) = 'TED_CN']">
        <assert id="EHF-ESPD-R211"
                test="not(cbc:IssueDate) and not(cbc:IssueTime)"
                flag="fatal">TED reference MUST NOT contain issue date and issue time.</assert>
        <assert id="EHF-ESPD-R212"
                test="cbc:ID"
                flag="fatal">TED reference MUST contain an identifier.</assert>
        <assert id="EHF-ESPD-R213"
                test="matches(normalize-space(cbc:ID/text()), '^[0-9]{4}/S [0-9]{3}\-[0-9]{6}$')"
                flag="fatal">TED reference MUST match '[][][][]/S [][][]-[][][][][][]' (e.g. 2015/S 252-461137).</assert>
        <assert id="EHF-ESPD-R214"
                test="normalize-space(cbc:ID/text()) != '0000/S 000-000000'"
                flag="fatal">TED reference MUST not be a temporary value.</assert>
    </rule>

    <rule context="cac:AdditionalDocumentReference[/espd:ESPDResponse][normalize-space(cbc:DocumentTypeCode) = 'ESPD_REQUEST']">
        <assert id="EHF-ESPD-R221"
                test="not(cac:Attachment/cbc:URI)"
                flag="fatal">NGOJ reference MUST NOT contain issue date, issue time and attachment.</assert>
        <assert id="EHF-ESPD-R222"
                test="cbc:IssueDate"
                flag="fatal">ESPD Request reference MUST contain an issue date.</assert>
    </rule>

    <rule context="cac:AdditionalDocumentReference[normalize-space(cbc:DocumentTypeCode) = 'NGOJ']">
        <assert id="EHF-ESPD-R231"
                test="not(cac:Attachment) and not(cbc:IssueDate) and not(cbc:IssueTime)"
                flag="fatal">Doffin reference MUST NOT contain issue date, issue time and attachment.</assert>
        <assert id="EHF-ESPD-R233"
                test="matches(normalize-space(cbc:ID/text()), '^[0-9]{4}\-[0-9]{6}$')"
                flag="fatal">Doffin reference MUST match 'YYYY-[][][][][][]' (e.g. 2017-461137).</assert>
    </rule>

    <rule context="cac:AdditionalDocumentReference[/espd:ESPDResponse][normalize-space(cbc:DocumentTypeCode) = 'LOTS']">
        <!-- TODO -->
    </rule>

    <rule context="cac:AdditionalDocumentReference">
        <!-- Not allowed type -->
        <assert id="EHF-ESPD-R200"
                test="not(/espd-req:ESPDRequest)"
                flag="fatal">ESPD Request MUST contain only document reference 'NGOJ'.</assert>
        <assert id="EHF-ESPD-R201"
                test="not(/espd:ESPDResponse)"
                flag="fatal">ESPD Responst MUST contain only document references 'TED_CN', 'ESPD_REQUEST', 'NGOJ' and 'LOTS'.</assert>
    </rule>

    <!-- Formatting -->

    <rule context="cbc:IssueDate | cbc:BirthDate | cbc:Date">
        <assert id="EHF-ESPD-R020"
                test="(normalize-space(text()) castable as xs:date) and string-length(normalize-space(text())) = 10"
                flag="fatal">A date must be formatted YYYY-MM-DD.</assert>
    </rule>

    <rule context="cbc:IssueTime">
        <assert id="EHF-ESPD-R021"
                test="(normalize-space(text()) castable as xs:time) and string-length(normalize-space(text())) = 8"
                flag="fatal">A time must be formatted hh:mm:ss.</assert>
    </rule>

</pattern>
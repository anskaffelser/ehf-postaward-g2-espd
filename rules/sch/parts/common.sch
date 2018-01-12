<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <rule context="ccv:Requirement">
        <assert id="EHF-ESPD-R100"
                test="/espd-req:ESPDRequest and not(ccv:Response)"
                flag="fatal">Response MUST be provided in ESPD Response and MUST NOT be provided in ESPD Request.</assert>
        <assert id="EHF-ESPD-R101"
                test="/espd:ESPDRequest or not(ccv:Response) or count(ccv:Response/*) = 1"
                flag="fatal">Response MUST contain only the specified response type.</assert>
        <assert id="DEBUG"
                test="false()"
                flag="fatal">Test</assert>
    </rule>

    <rule context="ccv:Response">

    </rule>

    <rule context="cac:AdditionalDocumentReference[normalize-space(cbc:DocumentTypeCode) = 'TED_CN']">
        <assert id="EHF-ESPD-R210"
                test="/espd:ESPDResponse"
                flag="fatal">ESPD Request MUST NOT contain reference to TED.</assert>
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

    <rule context="cac:AdditionalDocumentReference[normalize-space(cbc:DocumentTypeCode) = 'ESPD_REQUEST']">
        <assert id="EHF-ESPD-R220"
                test="/espd:ESPDResponse"
                flag="fatal">ESPD Request reference MUST NOT contain reference to another ESPD Requesy.</assert>
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
                flag="fatal">NGOJ reference MUST NOT contain issue date, issue time and attachment.</assert>
        <!-- TODO Formatering av identifikator fra Doffin. -->
    </rule>

    <rule context="cac:AdditionalDocumentReference">
        <!-- Not allowed type -->
        <assert id="EHF-ESPD-R200"
                test="not(/espd-req:ESPDRequest)"
                flag="fatal">ESPD Request MUST contain only document reference 'NGOJ'.</assert>
        <assert id="EHF-ESPD-R201"
                test="not(/espd:ESPDResponse)"
                flag="fatal">ESPD Responst MUST contain only document references 'TED_CN', 'ESPD_REQUEST' and 'NGOJ'.</assert>
    </rule>

</pattern>
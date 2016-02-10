<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    <!-- Single file input -->
    <p:input port="source">
        <p:document href="Input/Mingoexport.xml" />
    </p:input>
    <!-- Single file output - need to change to iterate through the records and create filenames -->
    <p:output port="result" sequence="true">
        <p:pipe port="result" step="step1"></p:pipe>
    </p:output>
    <p:identity/>
    
    <p:for-each name="step1">
        <p:iteration-source select="//record"/>
        <p:output port="result"/>
        <p:variable name="fileName" select="record/cite-as/substring-after(., '4700')/>
        <p:store name="store">
            <p:with-option name="href" select="concat($fileName, '.xml')"/>
        </p:store>
        <p:identity>
            <p:input port="source">
                <p:pipe step="store" port="result"/>
            </p:input>
        </p:identity>
    </p:for-each>
</p:declare-step>
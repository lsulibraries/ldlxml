<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    <!-- Single file input -->
    <p:input port="source">
        <p:document href="Input/Mingoexport.xml" />
    </p:input>
    <!-- Single file output - need to change to iterate through the records and create filenames -->
    <p:output port="result">
        <p:pipe port="result" step="step1"></p:pipe>
    </p:output>
    <p:identity/>
    <p:store name="step1">
        <p:with-option name="href" select="'test.xml'"/>
    </p:store>
</p:declare-step>
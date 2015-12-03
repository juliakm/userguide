<?xml version="1.0" encoding="UTF-8"?>
<!--
        Do not edit this file directly!
        This file is generated automatically by processing 
        info-model.ditamap
        If you want to change the rules, edit the corresponding sections 
        marked with audience="rules" in the corresponding topic files.
      -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  queryBinding="xslt2">
   <sch:include href="library.sch#avoidWordInElement"/>
   <sch:include href="library.sch#avoidEndFragment"/>
   <sch:include href="library.sch#avoidAttributeInElement"/>
   <sch:include href="library.sch#recommendElementInParent"/>
   <sch:include href="library.sch#restrictWords"/>
   <!--Generated from topics/indexEntries.dita-->
   <sch:pattern is-a="avoidWordInElement">
      <sch:param name="word" value="oXygen"/>
      <sch:param name="element" value="indexterm"/>
      <sch:param name="message" value="We should avoid using oXygen inside index terms!"/>
   </sch:pattern>
   <!--Generated from topics/images.dita-->
   <sch:pattern is-a="avoidAttributeInElement">
      <sch:param name="element" value="image"/>
      <sch:param name="attribute" value="scale"/>
      <sch:param name="message"
             value="Dynamically scaled images are not properly displayed, you&#xA;            should scale the image with an image tool and keep it within&#xA;            the recommended with and height limits."/>
   </sch:pattern>
   <!--Generated from topics/lists.dita-->
   <sch:pattern is-a="avoidEndFragment">
      <sch:param name="fragment" value=";"/>
      <sch:param name="element" value="li"/>
      <sch:param name="message"
             value="List items should not end with a semi-column (;). If it is&#xA;            a sentence then end it with a full stop (.), otherwise leave&#xA;            it without an ending character."/>
   </sch:pattern>
  
  <!-- Check the the indexterm exist. -->
  <sch:pattern>
    <sch:rule context="/*">
      <sch:assert test="prolog/metadata/keywords/indexterm" role="warn" sqf:fix="addFragment">
        It is recommended to add an 'indexterm' in the current '<sch:name/>' element.
      </sch:assert>
      
      <sqf:fix id="addFragment">
        <sqf:description>
          <sqf:title>Add the 'indexterm' element</sqf:title>
        </sqf:description>
        
        <!-- Add the indexterm element element and its parents -->
        <sqf:add match="(title | titlealts | abstract | shortdesc)[last()]" position="after" use-when="not(prolog)">
          <xsl:text>
          </xsl:text><prolog><xsl:text>
            </xsl:text><metadata><xsl:text>
              </xsl:text><keywords><xsl:text>
                 </xsl:text><indexterm><xsl:text> </xsl:text> </indexterm><xsl:text>
              </xsl:text></keywords><xsl:text>
            </xsl:text></metadata><xsl:text>
          </xsl:text></prolog>
        </sqf:add>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  <!-- Topic ID must be equal to file name -->
  <sch:pattern>
    <sch:rule context="/*[1][contains(@class, ' topic/topic ')]">
      <sch:let name="reqId" value="replace(tokenize(document-uri(/), '/')[last()], '\.dita', '')"/>
      <sch:assert test="@id = $reqId" sqf:fix="setId">
        Topic ID must be equal to file name.
      </sch:assert>
      <sqf:fix id="setId">
        <sqf:description>
          <sqf:title>Set "<sch:value-of select="$reqId"/>" as a topic ID</sqf:title>
          <sqf:p>The topic ID must be equal to the file name.</sqf:p>
        </sqf:description>
        <sqf:replace match="@id" node-type="attribute" target="id" select="$reqId"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <!-- Report if link text same as @href value -->
  <sch:pattern>
    <sch:rule context="*[contains(@class, ' topic/xref ') or contains(@class, ' topic/link ')]">
      <sch:report test="@scope='external' and @href=text()" sqf:fix="removeText">
        Link text is same as @href attribute value. Please remove.
      </sch:report>
      <sqf:fix id="removeText">
        <sqf:description>
          <sqf:title>Remove redundant link text, text is same as @href value.</sqf:title>
        </sqf:description>
        <sqf:delete match="text()"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Image without any kind of reference -->
    <sch:rule context="*[contains(@class, ' topic/image ')]">
      <sch:report test="not(@href) and not(@keyref) and not(@conref) and not(@conkeyref)"> Image without
        a reference. </sch:report>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Report ul after ul -->
    <sch:rule context="*[contains(@class, ' topic/ul ')]">
      <sch:report test="following-sibling::node()[1][contains(@class, ' topic/ul ')]" role="warn"> Two
        consecutive unordered lists. You can probably merge them into one. </sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <!-- Report dl after dl -->
    <sch:rule context="*[contains(@class, ' topic/dl ')]">
      <sch:report test="following-sibling::node()[1][contains(@class, ' topic/dl ')]" role="warn"> Two
        consecutive definition lists. You can probably merge them into one. </sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <!-- Report ol after ol -->
    <sch:rule context="*[contains(@class, ' topic/ol ')]">
      <sch:report test="following-sibling::node()[1][contains(@class, ' topic/ol ')]" role="warn"> Two
        consecutive ordered lists. You can probably merge them into one. </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <!-- Report possible case in which a codeblock containg XML was not marked appropriately. -->
    <sch:rule context="*[contains(@class, ' pr-d/codeblock ')]" role="warn">
      <sch:report test="starts-with(text()[1], '&lt;') and not(@outputclass)"> Possible XML Codeblock
        without @outputclass set to it. </sch:report>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Report two consecutive note elements -->
    <sch:rule context="*[contains(@class, ' topic/note ')]">
      <sch:report test="preceding-sibling::node()[1][contains(@class, ' topic/note ')] and 
        @type=preceding-sibling::node()[1]/@type" role="warn"> Try to avoid inserting two consecutive notes with the same type. </sch:report>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Most DITA elements should not be empty -->
    <sch:rule
      context="
      *[not(contains(@class, ' topic/image '))]
      [not(contains(@class, ' topic/colspec '))]
      [not(contains(@class, ' map/topicref '))]
      [not(contains(@class, ' topic/data '))]
      [not(contains(@class, ' topic/vrm '))]
      [not(contains(@class, ' topic/entry '))]
      [not(contains(@class, ' topic/stentry '))]
      [not(@conref)]
      [not(@conkeyref)]
      [not(@keyref)]
      [not(@href)]
      [not(ancestor::*[@conref or @conkeyref])]">
      <sch:report test="not(node())"> Empty element. </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <!--Tables with more entries than number of columns -->
    <sch:rule context="*[contains(@class, ' topic/tgroup ')]">
      <sch:assert
        test="max(.//*[contains(@class, ' topic/row ')]/count(*[contains(@class, ' topic/entry ')])) = @cols"
        > Maximum number of entries must equal cols attribute specified on table.. </sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>

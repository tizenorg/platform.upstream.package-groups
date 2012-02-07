<?xml version="1.0" ?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#160;"> ]>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">

<xsl:output method="xml" indent="yes" name="xml"/>


<xsl:template match="comps">
   <xsl:for-each select="group">
   <xsl:variable name="filename"
     select="concat('patterns/',id,'.xml')" />

   <xsl:result-document href="{$filename}" format="xml">
    <pattern xmlns="http://novell.com/package/metadata/suse/pattern"
        xmlns:rpm="http://linux.duke.edu/metadata/rpm">
     <name><xsl:value-of select="id"/></name>
     <summary><xsl:value-of select="name"/></summary>
     <description><xsl:value-of select="description"/></description>
     <uservisible/>
     <category lang="en">Base Group</category>
     <rpm:requires>
     <xsl:for-each select="packagelist/packagereq">
         <xsl:variable name="pkg" select="."/>

        <rpm:entry name="{$pkg}"/>
     </xsl:for-each>
     </rpm:requires>
    </pattern>
    </xsl:result-document>
   </xsl:for-each>
</xsl:template>


</xsl:stylesheet>

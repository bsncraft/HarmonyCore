<CODEGEN_FILENAME>SwaggerFile.yaml</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.4.5</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>API_TITLE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>API_VERSION</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>API_DESCRIPTION</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_BASE_PATH</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_HTTPS_PORT</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_NAME</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataSwaggerYaml.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates YAML Swagger File documenting a Harmony Core API
;//
;// Copyright (c) 2018, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
# *****************************************************************************
#
#  Title:       SwaggerFile.yaml
# 
#  Description: Describes "<API_TITLE>" to Swagger UI
# 
# *****************************************************************************
#  WARNING: GENERATED CODE!
#  This file was generated by CodeGen. Avoid editing the file if possible.
#  Any changes you make will be lost of the file is re-generated.
# *****************************************************************************
# 
swagger: '2.0'

info:
  description: <API_DESCRIPTION>
  version: <API_VERSION>
  title: <API_TITLE>

host: '<SERVER_NAME>:<SERVER_HTTPS_PORT>'
basePath: /<SERVER_BASE_PATH>

schemes:
  - https

consumes:
  - application/json

produces:
  - application/json
;//
;//----------------------------------------------------------------------------
;//
;// Tags that can be applied to operations to categorize them
;//

tags:
<STRUCTURE_LOOP>
  - name: <StructurePlural>
    description: Operations related to <STRUCTURE_DESC>

</STRUCTURE_LOOP>
;//
;//----------------------------------------------------------------------------
;//
;// Operation paths
;//

paths:
<STRUCTURE_LOOP>
;//
;//----------------------------------------------------------------------------
;//
;// Get all records
;//
<IF DEFINED_ENABLE_GET_ALL>
<IF GET_ALL_ENDPOINT>
<COUNTER_1_RESET>
<COUNTER_1_INCREMENT>

  /<StructurePlural>:

    get:
      summary: Get all <structurePlural>
      description: Get all or a filtered collection of <structurePlural>.
      operationId: Get<StructurePlural>
      deprecated: false
      tags:
        - <StructurePlural>
<IF DEFINED_PARAM_OPTIONS_PRESENT>
      parameters:
</IF DEFINED_PARAM_OPTIONS_PRESENT>
<IF DEFINED_ENABLE_RELATIONS>
        - name: $expand
          in: query
          description: Expand one or more navigation properties.
          type: string
</IF DEFINED_ENABLE_RELATIONS>
<IF DEFINED_ENABLE_SELECT>
        - name: $select
          in: query
          description: List of properties to be returned.
          type: string
</IF DEFINED_ENABLE_SELECT>
<IF DEFINED_ENABLE_FILTER>
        - name: $filter
          in: query
          description: Filter expression to restrict returned rows.
          type: string
</IF DEFINED_ENABLE_FILTER>
<IF DEFINED_ENABLE_ORDERBY>
        - name: $orderby
          in: query
          description: Order by some property
          type: string
</IF DEFINED_ENABLE_ORDERBY>
<IF DEFINED_ENABLE_TOP>
        - name: $top
          in: query
          description: Maximum number of rows to return.
          type: integer
</IF DEFINED_ENABLE_TOP>
<IF DEFINED_ENABLE_SKIP>
        - name: $skip
          in: query
          description: Rows to skip before starting to return data.
          type: integer
</IF DEFINED_ENABLE_SKIP>
      responses:
        '200':
          description: OK
          schema:
            type: array
            items:
              $ref: '<StructureNoplural>Types.yaml#/<StructureNoplural>'
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
</IF GET_ALL_ENDPOINT>
</IF DEFINED_ENABLE_GET_ALL>
;//
;// POST
;//
<IF DEFINED_ENABLE_POST>
<IF POST_ENDPOINT>
<IF COUNTER_1_EQ_0>
  /<StructurePlural>:
</IF COUNTER_1_EQ_0>

    post:
      summary: Create a <structureNoplural>
      description: Create a new <structureNoplural>. When using a POST operation the primary key value will be assigned automatically. The primary key properties can be ommitted from the data in the request body, but if present will be ignored and replaced by automatically generated values.
      operationId: Post<StructureNoplural>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
        - name: a<StructureNoplural>
          in: body
          description: Data for <structureNoplural> to create.
          required: true
          schema:
            $ref: '<StructureNoplural>Types.yaml#/<StructureNoplural>Post'
      responses:
        '201':
          description: The <structureNoplural> was created. The data for the new <structureNoplural> will be included in the response body, including the auotmatically assigned primary key values, and the response will include a "Location" header indicating the URL that can be used to retrieve the newly created <structureNoplural>.
          schema:
            $ref: '<StructureNoplural>Types.yaml#/<StructureNoplural>'
        '400':
          description: Bad request
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
</IF POST_ENDPOINT>
</IF DEFINED_ENABLE_POST>
;//
;// GET Count
;//
<IF DEFINED_ENABLE_COUNT>
<IF GET_ENDPOINT>

  /<StructurePlural>/$count:

    get:
      summary: Count <structurePlural>
      description: Count all or a filtered collection of <structurePlural>.
      operationId: Count<StructurePlural>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
<IF DEFINED_ENABLE_FILTER>
        - name: $filter
          in: query
          description: Filter expression to restrict returned rows.
          type: string
</IF DEFINED_ENABLE_FILTER>
      responses:
        '200':
          description: OK
          schema:
            type: integer
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
</IF GET_ENDPOINT>
</IF DEFINED_ENABLE_COUNT>
;//
;//----------------------------------------------------------------------------
;//
;// Primary key operations
;//
;//
;// ----------------------------------------------------------------------------
;// Get via primary key
;//
<IF DEFINED_ENABLE_GET_ONE>
<IF GET_ENDPOINT>
<COUNTER_1_RESET>

  '/<StructurePlural>(<IF STRUCTURE_ISAM><PRIMARY_KEY><SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><FieldSqlName>=<IF ALPHA>''</IF ALPHA>{a<FieldSqlName>}<IF ALPHA>''</IF ALPHA><,></IF SEG_TAG_EQUAL></SEGMENT_LOOP></PRIMARY_KEY></IF STRUCTURE_ISAM><IF STRUCTURE_RELATIVE>a{RecordNumber}</IF STRUCTURE_RELATIVE>)':
<COUNTER_1_INCREMENT>

    get:
      summary: Get a single <structureNoplural>
      description: Get a <structureNoplural> via a complete primary key.
      operationId: Get<StructureNoplural>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
<IF STRUCTURE_ISAM>
<PRIMARY_KEY>
<SEGMENT_LOOP>
<IF SEG_TAG_EQUAL>
<ELSE>
        - name: a<FieldSqlName>
          in: path
          description: <SEGMENT_DESC>
          required: true
          type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
<IF DATE>
          format: date-time
</IF DATE>
<IF TIME>
          format: date-time
</IF TIME>
</IF SEG_TAG_EQUAL>
</SEGMENT_LOOP>
</PRIMARY_KEY>
</IF STRUCTURE_ISAM>
<IF STRUCTURE_RELATIVE>
        - name: aRecordNumber
          in: path
          description: Record number
          required: true
          type: integer
</IF STRUCTURE_RELATIVE>
<IF DEFINED_ENABLE_RELATIONS>
        - name: $expand
          in: query
          description: Expand one or more navigation properties.
          type: string
</IF DEFINED_ENABLE_RELATIONS>
<IF DEFINED_ENABLE_SELECT>
        - name: $select
          in: query
          description: List of properties to be returned.
          type: string
</IF DEFINED_ENABLE_SELECT>
      responses:
        '200':
          description: OK (the requested <structureNoplural> was found and returned)
          schema:
            $ref: '<StructureNoplural>Types.yaml#/<StructureNoplural>'
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
        '404':
          description: Not found (the requested <structureNoplural> was not found)
</IF GET_ENDPOINT>
</IF DEFINED_ENABLE_GET_ONE>
;//
;// ----------------------------------------------------------------------------
;// Delete via primary key
;//
<IF DEFINED_ENABLE_DELETE>
<IF DELETE_ENDPOINT>
<IF COUNTER_1_EQ_0>

  '/<StructurePlural>(<IF STRUCTURE_ISAM><PRIMARY_KEY><SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><FieldSqlName>=<IF ALPHA>''</IF ALPHA>{a<FieldSqlName>}<IF ALPHA>''</IF ALPHA><,></IF SEG_TAG_EQUAL></SEGMENT_LOOP></PRIMARY_KEY></IF STRUCTURE_ISAM><IF STRUCTURE_RELATIVE>a{RecordNumber}</IF STRUCTURE_RELATIVE>)':
</IF COUNTER_1_EQ_0>
<COUNTER_1_INCREMENT>

    delete:
      summary: Delete <structureNoplural>
      description: Delete a <structureNoplural> via a complete primary key.
      operationId: Delete<StructureNoplural>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
<IF STRUCTURE_ISAM>
  <PRIMARY_KEY>
    <SEGMENT_LOOP>
      <IF SEG_TAG_EQUAL>
      <ELSE>
        - name: a<FieldSqlName>
          in: path
          description: <SEGMENT_DESC>
          required: true
          type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
      <IF DATE>
          format: date-time
      </IF DATE>
      <IF TIME>
          format: date-time
      </IF TIME>
      </IF SEG_TAG_EQUAL>
    </SEGMENT_LOOP>
  </PRIMARY_KEY>
</IF STRUCTURE_ISAM>
<IF STRUCTURE_RELATIVE>
        - name: aRecordNumber
          in: path
          description: Record number
          required: true
          type: integer
</IF STRUCTURE_RELATIVE>
      responses:
        '204':
          description: No content (the specified <structureNoplural> was deleted)
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
        '404':
          description: Not found content (the specified <structureNoplural> was not found)
</IF DELETE_ENDPOINT>
</IF DEFINED_ENABLE_DELETE>
;//
;// ----------------------------------------------------------------------------
;// Create or update via primary key
;//
<IF DEFINED_ENABLE_PUT>
<IF PUT_ENDPOINT>
<IF COUNTER_1_EQ_0>

  '/<StructurePlural>(<IF STRUCTURE_ISAM><PRIMARY_KEY><SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><FieldSqlName>=<IF ALPHA>''</IF ALPHA>{a<FieldSqlName>}<IF ALPHA>''</IF ALPHA><,></IF SEG_TAG_EQUAL></SEGMENT_LOOP></PRIMARY_KEY></IF STRUCTURE_ISAM><IF STRUCTURE_RELATIVE>a{RecordNumber}</IF STRUCTURE_RELATIVE>)':
</IF COUNTER_1_EQ_0>
<COUNTER_1_INCREMENT>

    put:
      summary: Create or update <structureNoplural>
      description: Create or update a <structureNoplural> via a complete primary key.
      operationId: CreateOrUpdate<StructureNoplural>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
<IF STRUCTURE_ISAM>
  <PRIMARY_KEY>
    <SEGMENT_LOOP>
      <IF SEG_TAG_EQUAL>
      <ELSE>
        - name: a<FieldSqlName>
          in: path
          description: <SEGMENT_DESC>
          required: true
          type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
      <IF DATE>
          format: date-time
      </IF DATE>
      <IF TIME>
          format: date-time
      </IF TIME>
      </IF SEG_TAG_EQUAL>
    </SEGMENT_LOOP>
  </PRIMARY_KEY>
</IF STRUCTURE_ISAM>
<IF STRUCTURE_RELATIVE>
        - name: aRecordNumber
          in: path
          description: Record number
          required: true
          type: integer
</IF STRUCTURE_RELATIVE>
        - name: a<StructureNoplural>
          in: body
          description: Data for <structureNoplural> to create or update.
          required: true
          schema:
            $ref: '<StructureNoplural>Types.yaml#/<StructureNoplural>'
      responses:
        '201':
          description: Created (the <structureNoplural> was created)
          schema:
            $ref: '<StructureNoplural>Types.yaml#/<StructureNoplural>'
        '204':
          description: No Content (the <structureNoplural> was updated)
        '400':
          description: Bad request
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
</IF PUT_ENDPOINT>
</IF DEFINED_ENABLE_PUT>
;//
;// ----------------------------------------------------------------------------
;// Patch via primary key
;//
<IF DEFINED_ENABLE_PATCH>
<IF PATCH_ENDPOINT>
<IF COUNTER_1_EQ_0>

  '/<StructurePlural>(<IF STRUCTURE_ISAM><PRIMARY_KEY><SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><FieldSqlName>=<IF ALPHA>''</IF ALPHA>{a<FieldSqlName>}<IF ALPHA>''</IF ALPHA><,></IF SEG_TAG_EQUAL></SEGMENT_LOOP></PRIMARY_KEY></IF STRUCTURE_ISAM><IF STRUCTURE_RELATIVE>a{RecordNumber}</IF STRUCTURE_RELATIVE>)':
</IF COUNTER_1_EQ_0>
<COUNTER_1_INCREMENT>

    patch:
      summary: Patch <structureNoplural>
      description: Patch a <structureNoplural> via complete primary key.
      operationId: Patch<StructureNoplural>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
<IF STRUCTURE_ISAM>
  <PRIMARY_KEY>
    <SEGMENT_LOOP>
      <IF SEG_TAG_EQUAL>
      <ELSE>
        - name: a<FieldSqlName>
          in: path
          description: <SEGMENT_DESC>
          required: true
          type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
      <IF DATE>
          format: date-time
      </IF DATE>
      <IF TIME>
          format: date-time
      </IF TIME>
      </IF SEG_TAG_EQUAL>
    </SEGMENT_LOOP>
  </PRIMARY_KEY>
</IF STRUCTURE_ISAM>
<IF STRUCTURE_RELATIVE>
        - name: aRecordNumber
          in: path
          description: Record number
          required: true
          type: integer
</IF STRUCTURE_RELATIVE>
        - name: aPatchDocument
          in: body
          description: JSON patch document describing the changes to make to the <structureNoplural>.
          required: true
          schema:
            $ref: '#/definitions/PatchRequest'
      responses:
        '204':
          description: No content (the specified <structureNoplural> was patched)
        '400':
          description: Bad request
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
        '404':
          description: Not found (the specified <structureNoplural> was not found)
</IF PATCH_ENDPOINT>
</IF DEFINED_ENABLE_PATCH>
;//
;//----------------------------------------------------------------------------
;//
;// Alternate key operations
;//
<IF STRUCTURE_ISAM>
<IF DEFINED_ENABLE_ALTERNATE_KEYS>
<IF ALTERNATE_KEY_ENDPOINTS>
<ALTERNATE_KEY_LOOP>

  '/<StructurePlural>(<SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><FieldSqlName>=<IF ALPHA>''</IF ALPHA>{a<FieldSqlName>}<IF ALPHA>''</IF ALPHA><,></IF SEG_TAG_EQUAL></SEGMENT_LOOP>)':
;//
;// ----------------------------------------------------------------------------
;// Get via alternate key
;//

    get:
  <IF DUPLICATES>
      summary: Get <structurePlural>
      description: Get a <structurePlural> via complete alternate key <KeyName>.
      operationId: Get<StructurePlural>ByKey<KeyName>
  <ELSE>
      summary: Get <structureNoplural>
      description: Get a <structureNoplural> via complete alternate key <KeyName>.
      operationId: <StructureNoplural>ByKey<KeyName>
  </IF DUPLICATES>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
  <SEGMENT_LOOP>
    <IF SEG_TAG_EQUAL>
    <ELSE>
        - name: a<FieldSqlName>
          in: path
          description: <SEGMENT_DESC>
          required: true
          type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
      <IF DATE>
          format: date-time
      </IF DATE>
      <IF TIME>
          format: date-time
      </IF TIME>
    </IF SEG_TAG_EQUAL>
  </SEGMENT_LOOP>
  <IF DEFINED_ENABLE_RELATIONS>
        - name: $expand
          in: query
          description: Expand one or more navigation properties.
          type: string
  </IF DEFINED_ENABLE_RELATIONS>
  <IF DEFINED_ENABLE_SELECT>
        - name: $select
          in: query
          description: List of properties to be returned.
          type: string
  </IF DEFINED_ENABLE_SELECT>
  <IF DUPLICATES>
    <IF DEFINED_ENABLE_ORDERBY>
        - name: $orderby
          in: query
          description: Order by some property
          type: string
    </IF DEFINED_ENABLE_ORDERBY>
    <IF DEFINED_ENABLE_FILTER>
        - name: $filter
          in: query
          description: Filter expression to restrict returned rows.
          type: string
    </IF DEFINED_ENABLE_FILTER>
    <IF DEFINED_ENABLE_TOP>
        - name: $top
          in: query
          description: Maximum number of rows to return.
          type: integer
    </IF DEFINED_ENABLE_TOP>
    <IF DEFINED_ENABLE_SKIP>
        - name: $skip
          in: query
          description: Rows to skip before starting to return data.
          type: integer
    </IF DEFINED_ENABLE_SKIP>
  </IF DUPLICATES>
      responses:
        '200':
          description: OK
          schema:
  <IF DUPLICATES>
            type: array
            items:
              $ref: '<StructureNoplural>Types.yaml#/<StructureNoplural>'
  <ELSE>
            $ref: '<StructureNoplural>Types.yaml#/<StructureNoplural>'
  </IF DUPLICATES>
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
;//
;// ----------------------------------------------------------------------------
;// Get count via alternate key
;//
  <IF DEFINED_ENABLE_COUNT>
    <IF DUPLICATES>

  '/<StructurePlural>(<SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><FieldSqlName>=<IF ALPHA>''</IF ALPHA>{a<FieldSqlName>}<IF ALPHA>''</IF ALPHA><,></IF SEG_TAG_EQUAL></SEGMENT_LOOP>)/$count':

    get:
      summary: Count <structurePlural>
      description: Count <structurePlural> via complete alternate key <KeyName>.
      operationId: Count<StructurePlural>ByKey<KeyName>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
      <SEGMENT_LOOP>
        <IF SEG_TAG_EQUAL>
        <ELSE>
        - name: a<FieldSqlName>
          in: path
          description: <SEGMENT_DESC>
          required: true
          type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
          <IF DATE>
          format: date-time
          </IF DATE>
          <IF TIME>
          format: date-time
          </IF TIME>
        </IF SEG_TAG_EQUAL>
      </SEGMENT_LOOP>
      <IF DEFINED_ENABLE_FILTER>
        - name: $filter
          in: query
          description: Filter expression to restrict returned rows.
          type: string
      </IF DEFINED_ENABLE_FILTER>
      responses:
        '200':
          description: OK
          schema:
            type: integer
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
    </IF DUPLICATES>
  </IF DEFINED_ENABLE_COUNT>
</ALTERNATE_KEY_LOOP>
</IF ALTERNATE_KEY_ENDPOINTS>
</IF DEFINED_ENABLE_ALTERNATE_KEYS>
</IF STRUCTURE_ISAM>
;//
;// ----------------------------------------------------------------------------
;// Single property operations
;//
<IF DEFINED_ENABLE_PROPERTY_ENDPOINTS>
<IF PROPERTY_ENDPOINTS>
<FIELD_LOOP>
<IF NOTPKSEGMENT>
<IF CUSTOM_NOT_HARMONY_EXCLUDE>
;//
;// Invividual property
;//

  '/<StructurePlural>(<IF STRUCTURE_ISAM><PRIMARY_KEY><IF SINGLE_SEGMENT>{key}<ELSE><SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><FieldSqlName>=<IF ALPHA>''</IF ALPHA>{a<FieldSqlName>}<IF ALPHA>''</IF ALPHA><,></IF SEG_TAG_EQUAL></SEGMENT_LOOP></IF SINGLE_SEGMENT></PRIMARY_KEY></IF STRUCTURE_ISAM><IF STRUCTURE_RELATIVE>{RecordNumber}</IF STRUCTURE_RELATIVE>)/<FieldSqlName>':

    get:
      summary: Get <structureNoplural> property <FieldSqlName>
      description: Get <structureNoplural> property <FieldSqlName> via complete primary key.
      operationId: <StructureNoplural><FieldSqlName>
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
    <IF STRUCTURE_ISAM>
      <PRIMARY_KEY>
        <SEGMENT_LOOP>
        <IF SEG_TAG_EQUAL>
        <ELSE>
        <IF SINGLE_SEGMENT>
        - name: key
        <ELSE>
        - name: a<FieldSqlName>
        </IF SINGLE_SEGMENT>
          in: path
          description: <SEGMENT_DESC>
          required: true
          type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
          <IF DATE>
          format: date-time
          </IF DATE>
          <IF TIME>
          format: date-time
          </IF TIME>
          </IF SEG_TAG_EQUAL>
          </SEGMENT_LOOP>
      </PRIMARY_KEY>
    </IF STRUCTURE_ISAM>
    <IF STRUCTURE_RELATIVE>
        - name: RecordNumber
          in: path
          description: Record number
          required: true
          type: integer
    </IF STRUCTURE_RELATIVE>
      responses:
        '200':
          description: OK (the selected <structureNoplural> was founn and the requested property was returned)
          schema:
            type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
        '404':
          description: Not found (the specified <structureNoplural> was not found)
;//
;// Invividual property - value only
;//
<IF DEFINED_ENABLE_PROPERTY_VALUE_DOCS>

  '/<StructurePlural>(<IF STRUCTURE_ISAM><PRIMARY_KEY><IF SINGLE_SEGMENT>{key}<ELSE><SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><FieldSqlName>=<IF ALPHA>''</IF ALPHA>{a<FieldSqlName>}<IF ALPHA>''</IF ALPHA><,></IF SEG_TAG_EQUAL></SEGMENT_LOOP></IF SINGLE_SEGMENT></PRIMARY_KEY></IF STRUCTURE_ISAM><IF STRUCTURE_RELATIVE>{RecordNumber}</IF STRUCTURE_RELATIVE>)/<FieldSqlName>/$value':

    get:
      summary: Get <structureNoplural> property <FieldSqlName>
      description: Get <structureNoplural> property <FieldSqlName> via complete primary key, returning the raw value.
      operationId: <StructureNoplural><FieldSqlName>value
      deprecated: false
      tags:
        - <StructurePlural>
      parameters:
    <IF STRUCTURE_ISAM>
      <PRIMARY_KEY>
        <SEGMENT_LOOP>
        <IF SEG_TAG_EQUAL>
        <ELSE>
        <IF SINGLE_SEGMENT>
        - name: key
        <ELSE>
        - name: a<FieldSqlName>
        </IF SINGLE_SEGMENT>
          in: path
          description: <SEGMENT_DESC>
          required: true
          type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
          <IF DATE>
          format: date-time
          </IF DATE>
          <IF TIME>
          format: date-time
          </IF TIME>
        </IF SEG_TAG_EQUAL>
        </SEGMENT_LOOP>
      </PRIMARY_KEY>
    </IF STRUCTURE_ISAM>
    <IF STRUCTURE_RELATIVE>
        - name: RecordNumber
          in: path
          description: Record number
          required: true
          type: integer
    </IF STRUCTURE_RELATIVE>
      responses:
        '200':
          description: OK (the selected <structureNoplural> was founn and the requested property was returned)
          schema:
            type: <IF ALPHA>string</IF ALPHA><IF DECIMAL><IF PRECISION>number<ELSE>integer</IF PRECISION></IF DECIMAL><IF DATE>string</IF DATE><IF TIME>string</IF TIME><IF INTEGER>number</IF INTEGER>
        <IF DEFINED_ENABLE_AUTHENTICATION>
        '401':
          description: Unauthorized
        </IF DEFINED_ENABLE_AUTHENTICATION>
        '404':
          description: Not found (the specified <structureNoplural> was not found)
</IF DEFINED_ENABLE_PROPERTY_VALUE_DOCS>
</IF CUSTOM_NOT_HARMONY_EXCLUDE>
</IF NOTPKSEGMENT>
</FIELD_LOOP>
</IF PROPERTY_ENDPOINTS>
</IF DEFINED_ENABLE_PROPERTY_ENDPOINTS>
</STRUCTURE_LOOP>
;//
;//----------------------------------------------------------------------------
;//
;// Configure an authentication server (Needs more work before implementation)
;//
<IF DEFINED_ENABLE_AUTHENTICATION>
securityDefinitions:
  OauthSecurity:
    type: oauth2
    flow: password
    tokenUrl: <OAUTH_SERVER>/connect/token
    scopes:
      api1: Access to API1
security:
  - OauthSecurity: []
</IF DEFINED_ENABLE_AUTHENTICATION>
;//----------------------------------------------------------------------------
;//
;// Definitions of data models.
;// The definitions for each type are included from a separate YAML file.
;//
definitions:
;//
;//----------------------------------------------------------------------------
;// Data model definitions for PATCH requests
;//
  PatchRequest:
    type: array
    items:
      $ref: '#/definitions/PatchDocument'
  PatchDocument:
    description: A JSONPatch document as defined by RFC 6902
    required:
      - op
      - path
    properties:
      op:
        type: string
        description: The operation to be performed
        enum:
          - add
          - remove
          - replace
          - move
          - copy
          - test
      path:
        type: string
        description: A JSON-Pointer
      value:
        type: object
        description: The value to be used within the operations.
      from:
        type: string
        description: A string containing a JSON Pointer value.
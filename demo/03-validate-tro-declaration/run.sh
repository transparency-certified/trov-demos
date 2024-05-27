#!/usr/bin/env bash

# paths to data files
TRO_DECLARATION_SCHEMA_PATH="data/tro.schema.ttl"
MAPPINGS_PATH="data/mappings.json"

# ------------------------------------------------------------------------------

bash_cell 'tro validation 1 txt: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro1.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 1 html: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro1.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro1 -of html

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 2 txt: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro2.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 2 html: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro2.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro2 -of html

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 3 txt: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro3.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 3 html: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro3.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro3 -of html

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 4 txt: lack of sha256' << END_CELL

rdfvr -f data/tro4.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 4 html: lack of sha256' << END_CELL

rdfvr -f data/tro4.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro4 -of html

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 txt: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 html: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro5 -of html

END_CELL

# ------------------------------------------------------------------------------

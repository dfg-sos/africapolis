class: CommandLineTool
$namespaces:
  eo: "https://dfg-sos.github.io/ontologies/eo-formats#"
  sos: "https://dfg-sos.github.io/ontologies/cwl#"
$schemas:
  - https://dfg-sos.github.io/ontologies/releases/eo-formats/1.0.0/eo-formats.owl
cwlVersion: v1.2
baseCommand: [SympolisPolygonOutline]
hints:
  DockerRequirement:
    dockerPull: ghcr.io/dfg-sos/sympolis:latest
requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMin: 1
    ramMin: 8192
inputs:
  vectorFile:
    type: File
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    inputBinding:
      prefix: -i
  mstFile:
    type: File
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    inputBinding:
      prefix: -m
  initialBuffer:
    type: float?
    inputBinding:
      position: 2
      prefix: --initial-buffer
    doc: "Width in meters of the buffer grown around each settlement before it is eroded back to buffer. Defaults to 100.0 when omitted"
  buffer:
    type: float
    inputBinding:
      position: 3
      prefix: --buffer
    doc: "Width in meters of the buffer remaining around the settlements of a cluster after erosion"
  debug:
    type: boolean
    default: false
    inputBinding:
      prefix: --debug
    doc: "Enable debug logging"
outputs:
  outlineVectorFile:
    type: File
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    outputBinding:
      glob: "*.gpkg"
    doc: "Output vector file with polygon outlines"

cwlVersion: v1.2
class: CommandLineTool
$namespaces:
  eo: "https://dfg-sos.github.io/ontologies/eo-formats#"
  sos: "https://dfg-sos.github.io/ontologies/cwl#"
$schemas:
  - https://dfg-sos.github.io/ontologies/releases/eo-formats/1.0.0/eo-formats.owl
baseCommand: [SympolisEdgeVisualization]
hints:
  DockerRequirement:
    dockerPull: ghcr.io/dfg-sos/sympolis:latest
requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMin: 1
    ramMin: 4096
inputs:
  geometryFiles:
    type: File[]
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    doc: "Input vector files storing the settlements of the graph"
    inputBinding:
      prefix: -i
  graphFile:
    type: File
    # format: BIN
    doc: "Input binary file storing the settlement graph adjacency"
    inputBinding:
      prefix: -g
  outputStem:
    type: string
    doc: "Output filename stem for storing the edges of the graph"
    inputBinding:
      prefix: -o
outputs:
  edgeVectorFile:
    type: File
    format: eo:GeoPackage
    sos:expectedGeometryType: "Polygon"
    outputBinding:
      glob: $(inputs.outputStem + "_edges.gpkg")
    doc: "Vector file storing one polygon per edge of the settlement graph"

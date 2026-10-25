cwlVersion: v1.2
class: CommandLineTool
$namespaces:
  eo: "https://dfg-sos.github.io/ontologies/eo-formats#"
  sos: "https://dfg-sos.github.io/ontologies/cwl#"
$schemas:
  - https://dfg-sos.github.io/ontologies/releases/eo-formats/1.0.0/eo-formats.owl
baseCommand: [SympolisMSTVisualization]
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
        doc: "Input vector files to visualize the edges of the graph"
        inputBinding:
            prefix: "-i"
    graphFile:
        type: File
        doc: "Input graph binary file"
        inputBinding:
            prefix: "-g"
    outputStem:
        type: string
        doc: "Output stem for the output vector file"
        inputBinding:
            prefix: "-o"
    buffer:
        type: float?
        doc: "Width in meters of the buffer applied to the MST edges. Defaults to 30.0 when omitted"
        inputBinding:
            prefix: "--buffer"
    debug:
        type: boolean
        default: false
        doc: "Enable debug logging"
        inputBinding:
            prefix: "--debug"
outputs:
    mstVectorFile:
        type: File
        format: eo:GeoPackage
        sos:expectedGeometryType: "Polygon"
        outputBinding:
            glob: $(inputs.outputStem + "_mst.gpkg")

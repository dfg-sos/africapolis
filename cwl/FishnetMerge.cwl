cwlVersion: v1.2
class: CommandLineTool
$namespaces:
  eo: "https://dfg-sos.github.io/ontologies/eo-formats#"
$schemas:
  - https://dfg-sos.github.io/ontologies/releases/eo-formats/1.0.0/eo-formats.owl
baseCommand: [FishnetVectorFileMerger]
hints:
  DockerRequirement:
    dockerPull: ghcr.io/descartesresearch/fishnet-apps:2.0.1
requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMin: 1
    ramMin: 8192
inputs:
  vectorFiles:
    type: File[]
    format: eo:GeoPackage
    inputBinding:
        prefix: -i
    doc: "List of input vector files, with their required secondary files (.dbf, .shx, .prj)"
  outputPath:
    type: string
    inputBinding:
        position: 2
        prefix: -o 
        valueFrom: $(self+".gpkg")
    doc: "Output filename for result (Vectorfile)"  
outputs:
  mergedOutput:
    type: File
    format: eo:GeoPackage
    outputBinding:
        glob: "$(inputs.outputPath).gpkg"
    doc: "Merged output file"
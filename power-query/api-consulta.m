let
    Source = 
        Json.Document(
            Web.Contents(
                urlBase,
                [
                    RelativePath="/api/v1/",
                    Query=[
                        organizationId=organizationId,
                        workflowId="<WORKFLOW_ID>"
                    ],
                    Headers=[Authorization="Bearer " & getToken()]
                ]
            )
        ),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), {"Data"}, null, ExtraValues.Error)
in 
    #"Converted to Table"
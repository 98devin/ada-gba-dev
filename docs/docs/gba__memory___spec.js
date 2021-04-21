GNATdoc.Documentation = {
  "label": "GBA.Memory",
  "qualifier": "",
  "summary": [
  ],
  "description": [
  ],
  "entities": [
    {
      "entities": [
        {
          "label": "Address",
          "qualifier": "",
          "line": 9,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 9,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "System.Address"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 10,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "0000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "FFFFFFF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            },
            {
              "kind": "paragraph",
              "children": [
                {
                  "kind": "span",
                  "text": "Total addressable memory of 28 bits.\n"
                }
              ]
            }
          ]
        },
        {
          "label": "BIOS_Address",
          "qualifier": "",
          "line": 12,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 12,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "BIOS_Address",
                      "href": "docs/gba__memory___spec.html#L12C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 13,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "0000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "00003FFF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "label": "External_WRAM_Address",
          "qualifier": "",
          "line": 15,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 15,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "External_WRAM_Address",
                      "href": "docs/gba__memory___spec.html#L15C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 16,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "2000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "203FFFF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "label": "Internal_WRAM_Address",
          "qualifier": "",
          "line": 18,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 18,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Internal_WRAM_Address",
                      "href": "docs/gba__memory___spec.html#L18C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 19,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "3000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "3007FFF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "label": "IO_Register_Address",
          "qualifier": "",
          "line": 24,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 24,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "IO_Register_Address",
                      "href": "docs/gba__memory___spec.html#L24C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 25,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "4000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "40003FF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "label": "OAM_Address",
          "qualifier": "",
          "line": 33,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 33,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "OAM_Address",
                      "href": "docs/gba__memory___spec.html#L33C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 34,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "7000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "70003FF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "label": "Palette_RAM_Address",
          "qualifier": "",
          "line": 27,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 27,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Palette_RAM_Address",
                      "href": "docs/gba__memory___spec.html#L27C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 28,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "5000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "50003FF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "label": "Reserved_Internal_WRAM_Adddress",
          "qualifier": "",
          "line": 21,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 21,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Reserved_Internal_WRAM_Adddress",
                      "href": "docs/gba__memory___spec.html#L21C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Internal_WRAM_Address",
                      "href": "docs/gba__memory___spec.html#L18C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 22,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "3007F00"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "3007FFF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "label": "ROM_Address",
          "qualifier": "",
          "line": 36,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 36,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "ROM_Address",
                      "href": "docs/gba__memory___spec.html#L36C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 37,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "8000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "DFFFFFF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "label": "Video_RAM_Address",
          "qualifier": "",
          "line": 30,
          "column": 11,
          "src": "srcs/GBA.Memory.ads.html",
          "summary": [
          ],
          "description": [
            {
              "kind": "code",
              "children": [
                {
                  "kind": "line",
                  "number": 30,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "  "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "subtype"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Video_RAM_Address",
                      "href": "docs/gba__memory___spec.html#L30C11"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "is"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "Address",
                      "href": "docs/gba__memory___spec.html#L9C11"
                    }
                  ]
                },
                {
                  "kind": "line",
                  "number": 31,
                  "children": [
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": "    "
                    },
                    {
                      "kind": "span",
                      "cssClass": "keyword",
                      "text": "range"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "6000000"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ".."
                    },
                    {
                      "kind": "span",
                      "cssClass": "text",
                      "text": " "
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "16"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "number",
                      "text": "6017FFF"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": "#"
                    },
                    {
                      "kind": "span",
                      "cssClass": "identifier",
                      "text": ";"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ],
      "label": "Simple types"
    }
  ]
};
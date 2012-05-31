COMMERCIAL_OK = 1

LICENSES = [
    ["MIT License", 
        "http://www.opensource.org/licenses/mit-license", 
        "MIT",
        [COMMERCIAL_OK],
        ]
                
    ["BSD License", 
        "http://www.opensource.org/licenses/bsd-license", 
        "BSD",
        [COMMERCIAL_OK],
        ],
        
    ["Apache License 2.0",
        "http://www.opensource.org/licenses/apache2.0", 
        "APACHE",
        [COMMERCIAL_OK],
        ],
    
    ["Header of Apache License 2.0", 
        "http://www.opensource.org/licenses/apache2.0", 
        "APACHE_SHORT",
        [COMMERCIAL_OK],
        ],

    ["GNU General Public License, version 2 [GPLv2]", 
        "http://www.opensource.org/licenses/gpl-2.0.php", 
        "GPL2",
        [],
        ],

    ["Header of GNU General Public License, version 2 [GPLv2]", 
        "http://www.opensource.org/licenses/gpl-2.0.php", 
        "GPL2SHORT",
        [],
        ],

    ["GNU General Public License, version 3 [GPLv3]", 
        "http://www.opensource.org/licenses/gpl-3.0.html", 
        "GPL3",
        [],
        ],
        
    ["Header of GNU General Public License, version 3 [GPLv3]", 
        "http://www.opensource.org/licenses/gpl-3.0.html", 
        "GPL3SHORT",
        [],
        ],

    ]

for license in LICENSES
    $.get "licenses/#{ license[2] }.txt", (data) ->
        license[2] = data
        console.log license
    
console.log LICENSES

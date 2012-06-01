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

normalize_license_text = (text) -> text.replace(/\s+/gi, " ").replace(/\./gi, ".\n")
    
window.onload = ->
    window.all = []
    for license in LICENSES
        licenseCopy = license[..]
        txt = document.getElementById(license[2]).innerHTML
        document.getElementById(license[2]).innerHTML = ""
        licenseCopy[2] = normalize_license_text(txt)
        window.all.push licenseCopy
        
window.check = -> 
    try
        document.getElementById("result").style.display = "none"
        
        btn = document.getElementById("button")
        btn.value = "Calculating..."
        btn.enabled = false
        
        d = document.getElementById('data').value
        result = []
    
        # console.log d
    
        if d
            dmp = new diff_match_patch()
            dmp.Diff_EditCost = 4
        
            a = normalize_license_text(d)
                      
            for l in window.all
                b = l[2]

                diffs = dmp.diff_main(a, b, true)

                dmp.diff_cleanupEfficiency(diffs)

                mct = 0
               #        console.log diffs
                for item in diffs
                    if item[0] == DIFF_EQUAL 
                        mct += item[1].length 
                        # console.log "equal #{item[1]}"
            
                percent = (mct * 100.0 / a.length)
                
                console.log "mct #{mct} % #{percent} a #{ a.length} #{l[0]} #{  (mct * 100.0 / a.length) }" 

                diffhtml = dmp.diff_prettyHtml(diffs)                       
                result.push([percent * 1.0, l,  diffhtml])
            
                #c.match_count = mct
        
            #c.x = repr(diffs)
    
        result = result.sort((a,b) -> 
            a = a[0] 
            b = b[0]
            if a<b then 1 else if a>b then -1 else 0) 
        # console.log result
    
        # Show result
    
        html = ""
        c = 0
        for r in result          
            if (c > 0 and  r[0] < 20) or c > 2 then r[2] = "" 
            c += 1 
        
            html += """
             <li><a href="#{ r[1][1] }" target="_blank" title="Show full license" style="color:inherit; text-decoration"><strong>#{ r[1][0] }</strong> - #{ Math.round r[0] }% match into this license</a>
             """
             
            if 1 in r[1][3] 
                 html += """
                  <span class="ok">
                    OK FOR USE IN COMMERCIAL PRODUCTS
                  </span>
                  """

            if 1 not in r[1][3]
                 html += """
                   <span class="warn">
                    BETTER DON'T USE IN COMMERCIAL PRODUCTS
                  </span>
                  """

            if 2 in r[1][3]
                 html += """
                   <span class="warn">
                    DON'T FORGET TO ATTRIBUTE THE AUTHOR
                  </span>
                  """
            if r[2]
                 html += """
                  <div>
                    <div style="font-size: 10px;">
                    #{r[2]}
                    </div>
                    <br>
                  </div>
                  """

            html += "</li>"

        document.getElementById("result").style.display = "block"
        document.getElementById("list").innerHTML = html
        
        btn.value = "Check License"
        btn.enabled = true
        
      #  for x in result[1:3]:
      #      if x[0] < 20.:
      #          x[2] = None 
    
        #for x in result[3:]:
        #    x[2] = None 
     
    #    c.result = result
    #    c.d = d
    
    catch error
        # console.log error        
        false
        
    false

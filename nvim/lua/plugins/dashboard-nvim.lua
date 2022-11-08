local dashboard = require('dashboard')

dashboard.custom_header = {
    [[                                    ]],
    [[                                    ]],
    [[            __                      ]],
    [[           / /\                     ]],
    [[          / /  \                    ]],
    [[         / /    \__________         ]],
    [[        / /      \        /\        ]],
    [[       /_/        \      / /        ]],
    [[    ___\ \      ___\____/_/_        ]],
    [[   /____\ \    /___________/\       ]],
    [[   \     \ \   \           \ \      ]],
    [[    \     \ \   \____       \ \     ]],
    [[     \     \ \  /   /\       \ \    ]],
    [[      \   / \_\/   / /        \ \   ]],
    [[       \ /        / /__________\/   ]],
    [[        /        / /     /          ]],
    [[       /        / /     /           ]],
    [[      /________/ /\    /            ]],
    [[      \________\/\ \  /             ]],
    [[                  \_\/              ]],
    [[                                    ]],
    [[                                    ]],
    [[                                    ]]
}

dashboard.custom_center = {
   {
     icon = '  ',
     desc = 'Find Files in Project                              ',
     action = 'Telescope find_files',
     shortcut = 'Space p'
   },
   {
     icon = '  ',
     desc = 'Find Files in Directory                            ',
     action = 'Telescope find_files',
     shortcut = 'Space d'
   },
   {
     icon = '  ',
     desc = 'Grep Pattern in Project                            ',
     action = 'Telescope live_grep',
     shortcut = 'Space g'
   },
   {
     icon = '  ',
     desc = 'File Browser                                          ',
     action = 'NvimTreeToggle',
     shortcut = ', t'
   },
}

dashboard.custom_footer = {''}

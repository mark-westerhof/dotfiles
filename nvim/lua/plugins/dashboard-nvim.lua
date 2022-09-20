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
    [[                                    ]]
}

dashboard.custom_center = {
   {
     icon = '  ',
     desc = 'Find File                              ',
     action = 'Telescope find_files',
     shortcut = 'SPC p'
   },
   {
     icon = '  ',
     desc = 'File Browser                             ',
     action = 'NvimTreeToggle',
     shortcut = ', t'
   },
}

dashboard.custom_footer = {''}

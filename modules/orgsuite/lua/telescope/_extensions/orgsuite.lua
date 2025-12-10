local pickers = require("orgsuite.telescope")

return require("telescope").register_extension({
    exports = {
        search = pickers.search,
        refile = pickers.refile,
        insert_link = pickers.insert_link,
        links = pickers.forward_links,
        backlinks = pickers.backward_links,
        children = pickers.children,
    },
})

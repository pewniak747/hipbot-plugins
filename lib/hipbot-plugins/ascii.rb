# encoding: utf-8
class ASCII
  include Hipbot::Plugin

  TABLE_FLIPS = [
    '(╯°□°）╯︵ ┻━┻',
    '(╯°□°)╯︵ ┻━┻',
    '(ノ ゜Д゜)ノ ︵ ┻━┻',
    '‎(ﾉಥ益ಥ）ﾉ﻿ ┻━┻',
    "(╯'□')╯︵ ┻━┻",
    '(ﾉಥДಥ)ﾉ︵┻━┻',
    'ʕノ•ᴥ•ʔノ ︵ ┻━┻',
    '(/¯◡ ‿ ◡)/¯ ~ ┻━┻',
    '┗[© □ ©]┛ ︵ ┻━┻',
    '┻━┻ ︵ ლ(⌒-⌒ლ)',
  ]

  CLEAN_UPS = [
    '┬──┬﻿ ¯\\_(ツ)',
    '┬─┬ノ( º _ ºノ)',
    '(╯°Д°）╯︵ /(.□ . \\)',
    '(/ .□.)\\ ︵╰(゜Д゜)╯︵ /(.□. \\)',
    'ノ┬─┬ノ ︵ ( \\o°o)\\',
  ]

  scope global: true do
    on Regexp.union(TABLE_FLIPS) do
      reply(CLEAN_UPS.sample)
    end

    on Regexp.union(CLEAN_UPS) do
      reply(TABLE_FLIPS.sample)
    end

    on /\A\\o\/\z/ do
      reply('\o/')
    end

    on /\A\/o\/\z/ do
      reply('\\o\\')
    end

    on /\A\\o\\\z/ do
      reply('/o/')
    end
  end
end

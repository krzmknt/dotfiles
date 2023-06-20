local luasnip = require('luasnip')
local snip = luasnip.snippet
local text = luasnip.text_node
local insert = luasnip.insert_node

luasnip.add_snippets(nil, {
  python = {

    snip({
      trig = 'for',
      namr = 'for clause',
      dscr = 'Create markdown link [txt](url)'
    },
    {
      text('for '),
      insert(0, {'i', 'j'}),
      text(' in range('),
      insert(1, {'N'}),
      text({
          '):',
          '\t'
      }),
      insert(2),
    }),

    snip({
      trig = 'yesno',
      namr = 'for clause',
      dscr = 'Create markdown link [txt](url)'
    },
    {
      luasnip.c(1, {
        text({"print('YNeos'[1-ans::2])"}),
        insert(nil, {"At least I can edit something now"}),
        luasnip.f(function(args) return {"Still only counts as text!!"} end, {})
      }),
      insert(0),
    }),

    snip({
      trig = 'logger',
      namr = 'logger',
      dscr = 'logger'
    },
    {
      text({
        'from logging import getLogger, DEBUG, INFO, basicConfig',
        'logger = getLogger(__name__)',
        'logger.setLevel(DEBUG)',
        'fmt = "[%(levelname)s][%(lineno)d][%(funcName)s] %(message)s"',
        'basicConfig(format=fmt)',
        '',
      }),
    }),

    snip({
      trig = 'import',
      namr = 'import',
      dscr = 'import'
    },
    {
      text({
        'import bisect',
        'import collections',
        'import copy',
        'import heapq',
        'import itertools',
        'import math',
        'import string',
        'from collections import deque',
        'import sys',
        '',
      }),
    }),

    snip({
      trig = 'main',
      namr = 'main',
      dscr = 'main'
    },
    {
      text({
        'def main():',
        '\t',
      }),
      insert(0),
      text({
        '',
        '',
        '',
        "if __name__ == '__main__':",
        '\tmain()',
      }),
    }),

    snip({trig = 'b(%d)', regTrig = true, wordTrig = true}, {
      luasnip.f(function (args)
        return {
          "Captured Text: " .. args[1].captures[1] .. '.'
        }
      end, {}),
      insert(0)
    }),
  },
})


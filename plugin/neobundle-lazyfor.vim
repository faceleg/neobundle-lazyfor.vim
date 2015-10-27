" Inspired by https://raw.githubusercontent.com/hecomi/dotfiles/master/.vimrc
function! s:neobundle_lazy_for(bundle, ...)
  call neobundle#parser#lazy([a:bundle])
  let l:bundle = split( substitute(a:bundle, "['\", ]", '', 'g'), '/' )
  let l:name = l:bundle[len(l:bundle) - 1]

  let l:additional_configuration = {}
  let l:autoload = { 'autoload': {}}

  if a:0 == 1
    let l:additional_configuration = a:1
  endif

  if a:0 >= 2
    let l:autoload['autoload'][a:1] = a:2
  endif

  if a:0 == 3
    let l:additional_configuration = a:3
  endif

  if (has_key(l:additional_configuration, 'autoload'))
    call extend(l:autoload['autoload'], l:additional_configuration['autoload'])
  endif

  let l:configuration = {
        \ 'lazy' : 1,
        \ }

  call extend(l:configuration, l:additional_configuration)
  call extend(l:configuration, l:autoload)

  call neobundle#config(l:name, l:configuration)
endfunction

command! -nargs=+ NeoBundleLazyFor
      \ call s:neobundle_lazy_for(<args>)
"}}}

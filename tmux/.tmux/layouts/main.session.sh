session_root "~/repos/tngrm-core-api/"

if initialize_session "main"; then
  new_window "editor"

  run_cmd "nvim"

  split_h 15  
  run_cmd "lazygit"

  split_v 10  
  
  new_window "term"

  new_window "utils"
  run_cmd "btop"
  
  select_window 1
fi

finalize_and_go_to_session

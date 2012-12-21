Dir.glob('/home/template/chef-repo/cookbooks/samir_recipes/git-repo-perso-pushed-to-gitHub/cloudfoundry_all_in_one/start_platforme/templates/default/*.yml') do |rb_file|
 File.rename(rb_file,rb_file + ".erb") 
end

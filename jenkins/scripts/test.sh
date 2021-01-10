echo 'The following "npm" command (if executed) installs the "cross-env"'
echo 'dependency into the local "node_modules" directory, which will ultimately'
echo 'be stored in the Jenkins home directory. As described in'
echo 'https://docs.npmjs.com/cli/install, the "--save-dev" flag causes the'
echo '"cross-env" dependency to be installed as "devDependencies". For the'
echo 'purposes of this tutorial, this flag is not important. However, when'
echo 'installing this dependency, it would typically be done so using this'
echo 'flag. For a comprehensive explanation about "devDependencies", see'
echo 'https://stackoverflow.com/questions/18875674/whats-the-difference-between-dependencies-devdependencies-and-peerdependencies.'
set -x
npm install --save-dev cross-env
set +x
#enables a mode of the shell where all executed commands are printed to the terminal. it's clearly used for debugging, which is a typical use case for set -x : printing every command as it is executed may help you to visualize the control flow of the script
echo 'The following "npm" command tests that your simple Node.js/React'
echo 'application renders satisfactorily. This command actually invokes the test'
echo 'runner Jest (https://facebook.github.io/jest/).'
set -x
npm test
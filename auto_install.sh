SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"/scripts

# Execute (rather than source) the main
$SCRIPTS_DIR/avs-main.sh

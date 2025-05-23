YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# project_name="$1"
# feature_name="$2"

# [ ! -f mason.yaml ] && echo "No mason.yaml. Please run mason init" && exit 1
# [ ! -f mason-lock.json ] && echo "No mason-lock.json. Please run mason get" && exit 1

project_name=`basename $(pwd)`
# printf "${YELLOW}What is the project name? > ${NC}"
# read project_name
printf "${YELLOW}What is the feature name? > ${NC}"
read feature_name
printf "${YELLOW}What is the entity name? > ${NC}"
read entity
printf "${YELLOW}Do you need custom state? If yes name it and SimpleNotifier will be used, otherwise leave it blank and BaseState and BaseNotifier will be used. > ${NC}"
read custom_state

echo -e "${BLUE}Setup your entity:${NC}"
mason make entity --feature_name $feature_name --model_name $entity
echo -e "${BLUE}Setup your response/request model:${NC}"
mason make model --feature_name $feature_name
echo -e "${BLUE}Setup your repository:${NC}"
mason make repository --feature_name $feature_name --project_name $project_name
echo -e "${BLUE}Setup your notifier:${NC}"
if [ "$custom_state" = "" ]; then
    mason make notifier --feature_name $feature_name --project_name $project_name --entity $entity
else
    mason make simple_notifier --feature_name $feature_name --project_name $project_name --state $custom_state
fi
dart run build_runner build --delete-conflicting-outputs

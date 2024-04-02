repos_array=(
  "docker"
)

BRANCH=$1
PAT=$2

echo "$PAT"
echo "$BRANCH"

for repo in ${repos_array[@]}; do
  if [ "$repo" = "mailmunch" ] || [ "$repo" = "front-end-netlify" ]
  then
    REMOTE_BRANCH="$(git ls-remote --heads https://${PAT}@github.com/mailmunch/${repo}.git | grep -c 'refs/heads/MM-2353')"
    if [ "$REMOTE_BRANCH" = "1" ]
    then 
      echo "Cloning ${repo} from the branch MM-2353"
      git clone --single-branch --branch MM-2353 https://${PAT}@github.com/mailmunch/${repo}.git 
    else
      echo "Remote Branch MM-2353 doesn't exist in the https://${PAT}@github.com/mailmunch/${repo}.git"
      git clone https://${PAT}@github.com/mailmunch/${repo}.git
    fi
  else
    REMOTE_BRANCH="$(git ls-remote --heads https://${PAT}@github.com/mailmunch/${repo}.git ${BRANCH} | wc -l)"
    if [ "$REMOTE_BRANCH" = "1" ]
    then 
      echo "Cloning ${repo} from the branch ${BRANCH}"
      git clone --single-branch --branch ${BRANCH} https://${PAT}@github.com/mailmunch/${repo}.git 
    else
      if [ "$repo" = "front-end-netlify" ] && [ "${BRANCH}" = "master" ]
      then
        echo "Pulling main instead of master for front-end-netlify"
        git clone --single-branch --branch main https://${PAT}@github.com/mailmunch/${repo}.git
      else
        echo "Remote Branch ${BRANCH} doesn't exist in the https://${PAT}@github.com/mailmunch/${repo}.git"
        git clone https://${PAT}@github.com/mailmunch/${repo}.git
      fi
    fi
  fi
  echo $repo

  # After cloning, change into the repo directory
  cd ${repo}


  # Checkout into the branch MM-2353 if front-end-netlify or mailmunch
  if [ "$repo" = "mailmunch" ] || [ "$repo" = "front-end-netlify" ]
  then
    git checkout MM-2353
  else
    echo "Checking out ${BRANCH}"
  fi

  # Echo the current branch
  echo "Echo 2 Current branch in ${repo}: $(git rev-parse --abbrev-ref HEAD)"

  # Change back to the parent directory before the next iteration
  cd ..
done
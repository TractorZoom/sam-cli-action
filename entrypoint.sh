#!/bin/bash

set -u

function parseInputs(){
	# Required inputs
	if [ "${INPUT_SAM_COMMAND}" == "" ]; then
		echo "Input sam_subcommand cannot be empty"
		exit 1
	fi
}

function installAwsSam(){
	echo "Install aws-sam-cli ${INPUT_SAM_VERSION}"
	if [ "${INPUT_SAM_VERSION}" == "latest" ]; then
		pip install aws-sam-cli >/dev/null 2>&1
		if [ "${?}" -ne 0 ]; then
			echo "Failed to install aws-sam-cli ${INPUT_SAM_VERSION}"
		else
			echo "Successful install aws-sam-cli ${INPUT_SAM_VERSION}"
		fi
	else
		pip install aws-sam-cli==${INPUT_SAM_VERSION} >/dev/null 2>&1
		if [ "${?}" -ne 0 ]; then
			echo "Failed to install aws-sam-cli ${INPUT_SAM_VERSION}"
		else
			echo "Successful install aws-sam-cli ${INPUT_SAM_VERSION}"
		fi
	fi
}

function runSam(){
	echo "Run sam ${INPUT_SAM_COMMAND}"
	output=$(sam ${INPUT_SAM_COMMAND} 2>&1)
	exitCode=${?}
	echo "${output}"

	commentStatus="Failed"
	if [ "${exitCode}" == "0" ]; then
		commentStatus="Success"
	fi

	if [ "$GITHUB_EVENT_NAME" == "pull_request" ] && [ "${INPUT_ACTIONS_COMMENT}" == "true" ]; then
		commentWrapper="#### \`sam ${INPUT_SAM_COMMAND}\` ${commentStatus}
<details><summary>Show Output</summary>

\`\`\`
${output}
\`\`\`

</details>

*Workflow: \`${GITHUB_WORKFLOW}\`, Action: \`${GITHUB_ACTION}\`*"

		payload=$(echo "${commentWrapper}" | jq -R --slurp '{body: .}')
		commentsURL=$(cat ${GITHUB_EVENT_PATH} | jq -r .pull_request.comments_url)

		echo "${payload}" | curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data @- "${commentsURL}" > /dev/null
	fi
}

function main(){
	parseInputs
	installAwsSam
	runSam
}

main

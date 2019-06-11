# Versioning


## Prepare Xcode project

Prepare Xcode project by setting the Apple Generic versioning system:
- Go to project settings
- Choose tab „Build settings“
- Filter by „all“ and search for „versioning“
- Change „Current Project Version“ to „1“ and „Versioning System“ to „Apple Generic“
- Go to all target settings
- Choose tab „General“
- Change „Build“ to „[Under script control - see Build Phases]“

## 
## Install & Enable Git flow

Install Git-flow either through git-flow-avh (https://danielkummer.github.io/git-flow-cheatsheet/) or by using Sourcetree (https://www.sourcetreeapp.com) which has Git-flow natively built in.
Set up Git flow for your app.

Be very strict in tag naming, use Semantic Versioning (e.g. 2.1.3, or 2.3): https://semver.org

## 
## Install & Prepare Pod

Install pod itself: https://cocoapods.org

Create podspec (used to identify itself as pod’able app): 
pod spec create 

Use 
spec.source = { **:path** => '.' }
to distribute locally first

Install Auto tool to manipulate podspec versions:
*Podspec-bump* (https://github.com/azu/podspec-bump):
podspec-bump --increment “major“|“minor“|“patch“
podspec-bump --write “1.2.3“


## Instructions

1. *Prepare Xcode project* 
2. *Install & Enable Git flow* 
3. *Install & Prepare Pod* 
4. Download bash script „*update_version_numbers.sh*“ from https://github.com/Hokyo/update_version_numbers and paste it somewhere into your project file hierarchy
5. Make the script executable via your terminal: **chmod a+x update_version_numbers.sh** 
6. Go back to Xcode’s target settings and add a new „Run Script Phase“ to the end of our build phase
7. Under the „Shell“ box, add the following script: **$SRCROOT/update_version_numbers.sh**
8 Hint: Build code while being on the release or hotfix branch. This will make sure that the new or updated marketing number is being committed within that branch, instead of within the developer branch

#!/bin/bash
git add .
read -p 'Commit Note: ' commit_note
git commit -m "$commit_note"
git push stock master

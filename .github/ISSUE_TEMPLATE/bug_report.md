---
name: Bug report
about: Create a report to help us improve
title: ''
labels: ''
assignees: ''

---

name: "🐛 Bug Report"
description: Create a new ticket for a bug.
title: "🐛 [BUG] - <title>"
labels: ["bug"]
body:
  - type: textarea
    id: description
    attributes:
      label: "Description"
      description: Please enter an explicit description of your issue
      placeholder: Short and explicit description of your incident...
    validations:
      required: true
  - type: textarea
    id: reprod
    attributes:
      label: "Reproduction steps"
      description: Please enter an explicit description of your issue
      value: |
        1. Go to '...'
        2. Click on '....'
        3. Scroll down to '....'
        4. See error
      render: bash
    validations:
      required: true
  - type: textarea
    id: screenshot
    attributes:
      label: "Screenshots"
      description: If applicable, add screenshots to help explain your problem.
      value: |
        ![DESCRIPTION](LINK.png)
      render: bash
    validations:
      required: false
  - type: dropdown
    id: enviroment
    attributes:
      label: "Enviroment"
      description: What is the impacted environment ?
      multiple: true
      options:
        - Android
        - iOS
        - Windows
        - Linux
        - Mac
    validations:
      required: true

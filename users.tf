## Users
resource "aws_iam_user" "alice" {
  name = "alice"
}
resource "aws_iam_user" "malory" {
  name = "malory"
}
resource "aws_iam_user" "charlie" {
  name = "charlie"
}
resource "aws_iam_user" "bobby" {
  name = "bobby"
}

## Groups
resource "aws_iam_group" "marketing" {
  name = "marketing"
}

resource "aws_iam_group_membership" "marketing" {
  name = "group-membership-marketing"

  users = [
    aws_iam_user.alice.name,
    aws_iam_user.malory.name,
  ]

  group = aws_iam_group.marketing.name
}

resource "aws_iam_group" "hr" {
  name = "hr"
}

resource "aws_iam_group_membership" "hr" {
  name = "group-membership-hr"

  users = [
    aws_iam_user.charlie.name,
  ]

  group = aws_iam_group.hr.name
}

resource "aws_iam_group" "content" {
  name = "content"
}

resource "aws_iam_group_membership" "content" {
  name = "group-membership-content"

  users = [
    aws_iam_user.bobby.name,
  ]

  group = aws_iam_group.content.name
}

## Policies
data "aws_iam_policy_document" "marketing" {
  statement {
    effect    = "Allow"
    actions   = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:DeleteObject",
        "s3:DeleteObjectVersion"
    ]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}/news/*"]
  }
}

resource "aws_iam_group_policy" "marketing" {
  name  = "marketing_policy"
  group = aws_iam_group.marketing.name
  policy = data.aws_iam_policy_document.marketing.json
}

data "aws_iam_policy_document" "hr" {
  statement {
    effect    = "Allow"
    actions   = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:DeleteObject",
        "s3:DeleteObjectVersion"
    ]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}/people.html"]
  }
}

resource "aws_iam_group_policy" "hr" {
  name  = "hr_policy"
  group = aws_iam_group.hr.name
  policy = data.aws_iam_policy_document.hr.json
}

data "aws_iam_policy_document" "content" {
  statement {
    effect    = "Allow"
    actions   = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:DeleteObject",
        "s3:DeleteObjectVersion"
    ]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}/*"]
  }
}

resource "aws_iam_group_policy" "content" {
  name  = "content_policy"
  group = aws_iam_group.content.name
  policy = data.aws_iam_policy_document.content.json
}
